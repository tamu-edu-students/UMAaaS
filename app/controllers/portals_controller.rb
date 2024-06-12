# frozen_string_literal: true

class PortalsController < ApplicationController
  helper_method :has_program?,
                def has_program?
                  # puts params
                  participant = Participant.find_by(email: current_user.email, program_id: params[:id])
                  !participant.nil?
                end

  def index
    @programs = Program.where(disabled: false)
    print("ON PROGRAM PAGE\n")
    print('Logged in: ', logged_in?)
    return unless logged_in?

    # if logged in and the user already has a program selected, then automatically go that program portal
    print('Portal ID:', current_user.user_program_id)
    program = Program.find current_user.user_program_id unless current_user.user_program_id.nil?
    return if program.nil?

    redirect_to portal_path(program.id)
  end

  def program_select
    print('RUNNING PROGRAM SELECT')
    program = Program.find params[:program_id]

    # if(program.nil?) then
    #     flash[:notice] = "Pogram not found!"
    # else

    if logged_in?
      # save selected program to the user account so next time they don't have to select it
      print("Logged in YAY\n")
      print('ID IS:', current_user.user_program_id)
      user = User.find current_user.id
      unless user.nil?
        user.program_id = program.id
        user.save
        current_user.user_program_id = program.id
      end
    end
    redirect_to portal_path(program.id)
  end
  # end

  def program_view
    program = Program.find params[:program_id]
    if program.nil?
      flash[:notice] = 'Program not found!'
    else
      current_user.user_program_id = program.id
      redirect_to portal_path(program.id)
    end
  end

  def view
    # get this specific program
    @program = Program.find params[:id]
    # get list of all programs to display in drop down list for switching between
    @programs = Program.where(disabled: false)

    # get the search terms, if the search starts with "#", then only search tags
    searchTerm = nil
    searchTagsOnly = nil
    unless params[:search].blank?
      match = params[:search].match(/\A#\s*([0-9a-z -]+)/i)
      if !match.nil?
        searchTerm = match[1]
        searchTagsOnly = true
      else
        searchTerm = params[:search]
      end
    end

    if searchTagsOnly.nil? # Tips don't have tags, so if we're only searching tags then we can skip the tips

      # get all tips for this program
      @tips = Tip.left_outer_joins(:user).select('tips.*,users.name as user_name').where(tips: { program_id: params[:id] })

      searchResults = []

      @tips.each do |tip|
        found = true
        unless searchTerm.nil?
          found = false
          found = true if tip.tip =~ /#{searchTerm}/i
        end

        upvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: tip.id).where(users: { banned: false }).where(vote: 1).group(:tip_id).count(:vote).values[0]
        upvote_sum = 0 if upvote_sum.blank?
        tip.upvoteCount = upvote_sum

        downvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: tip.id).where(users: { banned: false }).where(vote: -1).group(:tip_id).count(:vote).values[0]
        downvote_sum = 0 if downvote_sum.blank?
        tip.downvoteCount = downvote_sum
                
        flag_sum = FlagTip.left_outer_joins(:user).where(tip_id: tip.id).where(users: {banned: false}).where(flag: 1).group(:tip_id).count(:flag).values[0]
        if flag_sum.blank? 
          flag_sum = 0
        end                 
        tip.flagCount = flag_sum

        tip.hasUserUpvoted = 0
        tip.hasUserDownvoted = 0
        helpful = HelpfulVote.select('vote').where(tip_id: tip.id).where(user_id: current_user.id).first
        unless helpful.nil?
          case helpful.vote
          when 1
            tip.hasUserUpvoted = 1
          when -1
            tip.hasUserDownvoted = 1
          end
        end

        tip.hasUserFlagged = 0
        flagged = FlagTip.select("flag").where(tip_id: tip.id).where(user_id: current_user.id).first
        if not flagged.nil?
          if flagged.flag == 1
            tip.hasUserFlagged = 1
          end
        end

        if found
          searchResults.push(tip) # only records matching the search term, if there is one, will be added to searchResults
        end
      end

      @tips = searchResults # put searchResults back into @tips for the view to use
    else
      @tips = []
    end

  
    # get all experiences for this program
    @experiences = Experience.left_outer_joins(:user).select('experiences.*,users.name as user_name').where(experiences: { program_id: params[:id] })
    #@experiences = Experience.all
  # @experiences = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select('experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating').where(experiences: { program_id: params[:id] }).where(users: { banned: false }).order(rating: :desc)


# puts("Hello")
    searchResults = []

    # for each experience get the comments associated with it and calculate the average rating
    @experiences.each do |exp|
      found = true
      if !searchTagsOnly.nil?
        found = false
        found = true if exp.tags =~ /,#{searchTerm},/i
      elsif !searchTerm.nil?
        found = false
        if (exp.title =~ /#{searchTerm}/i) || (exp.experience =~ /#{searchTerm}/i) || (exp.tags =~ /#{searchTerm}/i)
          found = true
        end
      end
      
      exp_flag_sum = FlagExperience.left_outer_joins(:user).where(experience_id: exp.id).where(users: {banned: false}).where(flag: 1).group(:experience_id).count(:flag).values[0]
        if exp_flag_sum.blank? 
          exp_flag_sum = 0
        end                 
      exp.flagCount = exp_flag_sum
      
      exp.hasUserFlagged = 0
      exp_flagged = FlagExperience.select("flag").where(experience_id: exp.id).where(user_id: current_user.id).first
      if not exp_flagged.nil?
        if exp_flagged.flag == 1
          exp.hasUserFlagged = 1
        end
      end
      
      exp.tagArray
      
      comment = ExperienceComment.where.not(rating: nil).find_by(user_id: current_user.id, experience_id: exp.id)
      if !comment.nil?
          # puts "commented true"
          exp.commented = true
      else 
          # puts "commented false"
          exp.commented = false
      end
      
      

      exp.comments = ExperienceComment.left_outer_joins(:user).select('experience_comments.*,users.name as user_name').where(experience_id: exp.id).where(users: { banned: false }).order(created_at: :desc).limit(Rails.configuration.max_comments_shown)

      exp.totalComments = ExperienceComment.left_outer_joins(:user).where(experience_id: exp.id).where(users: { banned: false }).count(:id)

      if searchTagsOnly.nil? && !searchTerm.nil?
        searchComments = exp.comments.where('comment LIKE ?', "%#{searchTerm}%")
        found = true if searchComments.size.positive?
      end

      rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: exp.id).where(users: { banned: false }).group(:experience_id).sum(:rating).values[0]
      if rating_sum.nil?
        rating_sum = exp.rating # just the original rating
      else
        rating_sum += exp.rating # add the original rating
      end
      rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: exp.id).where(users: { banned: false }).where.not(rating: nil).count(:id)
      rating_count += 1 # add 1 for the original rating
      exp.average_rating = (rating_sum.to_f / rating_count).round(1)
      
      exp.hasUserBookmarked = 0
      bookmarked = Bookmark.select("bookmarked").where(experience_id: exp.id).where(user_id: current_user.id).first
      if not bookmarked.nil?
          if bookmarked.bookmarked == 1
              exp.hasUserBookmarked = 1
          end
      end
      if found
        searchResults.push(exp) # only records matching the search term, if there is one, will be added to searchResults
      end
    end

    @experiences = searchResults # put searchResults back into @experiences for the view to use

    # for sorting the experiences
    @experience_sort_by = if params[:sort_exp].nil?
                            'avg_rating'
                          else
                            params[:sort_exp]
                          end

    # already sorted by rating by default, so only need to sort if some else is selected
    case @experience_sort_by
    when 'avg_rating'
      @experiences = @experiences.sort_by(&:average_rating).reverse!
    when 'rating_asc'
      @experiences = @experiences.sort_by(&:rating)
    when 'avg_rating_asc'
      @experiences = @experiences.sort_by(&:average_rating)
      @experiences = @experiences.sort_by(&:created_at).reverse!
    when 'comments'
      @experiences = @experiences.sort_by(&:totalComments).reverse!
    end
    

    # for sorting the tips
    @tip_sort_by = if params[:sort_tip].nil?
                     'helpful'
                   else
                     params[:sort_tip]
                   end

    # already sorted by helpful by default, so only need to sort if some else is selected
    case @tip_sort_by
    when 'helpful'
      @tips = @tips.sort_by { |x| x.upvoteCount - x.downvoteCount }.reverse!
    when 'date'
      @tips = @tips.sort_by(&:created_at).reverse!
    end
  end
end
