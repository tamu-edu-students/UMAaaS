# frozen_string_literal: true

class TipsController < ApplicationController
  # before_action :checkPrivilege

  # def checkPrivilege
  #     puts params
  #     participant = Participant.find_by(email: current_user.email, program_id: params[:id])
  #     if participant.nil?
  #         flash[:alert] = "You are not authorized to manage tips for this program"
  #         redirect_to portal_path(params[:id]) and return
  #     end
  # end

  def new
    @tip = Tip.new
    participant = Participant.find_by(email: current_user.email, program_id: params[:id])
    return unless participant.nil?

    flash[:alert] = 'You are not authorized to manage tips for this program'
    redirect_to portal_path(params[:id]) and return
  end

  def create
    participant = Participant.find_by(email: current_user.email, program_id: params[:id])
    if participant.nil?
      flash[:alert] = 'You are not authorized to manage tips for this program'
      redirect_to portal_path(params[:id]) and return
    end

    if params[:tip][:tip].blank? # tip text is required
      flash[:alert] = 'Cannot create tip'
      redirect_to portal_path(params[:id]) and return
    end

    Tip.create(tip: params[:tip][:tip], user_id: current_user.id, program_id: params[:id])
    redirect_to portal_path(params[:id])
  end

  def helpful
    @tip = Tip.left_outer_joins(:user).select('tips.*,users.name as user_name').where(tips: { id: params[:tipId] }).first

    participant = Participant.find_by(email: current_user.email, program_id: @tip.program_id)
    if participant.nil?
      flash[:alert] = 'You are not authorized to manage tips for this program'
      redirect_to portal_path(@tip.program_id) and return
    end

    HelpfulVote.where(tip_id: params[:tipId]).where(user_id: current_user.id).destroy_all
    unless params[:vote] == '0'

      HelpfulVote.create(vote: params[:vote], user_id: current_user.id, tip_id: params[:tipId])

    end

    upvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: @tip.id).where(users: { banned: false }).where(vote: 1).group(:tip_id).count(:vote).values[0]
    upvote_sum = 0 if upvote_sum.blank?
    @tip.upvoteCount = upvote_sum

    downvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: @tip.id).where(users: { banned: false }).where(vote: -1).group(:tip_id).count(:vote).values[0]
    downvote_sum = 0 if downvote_sum.blank?
    @tip.downvoteCount = downvote_sum

    @tip.hasUserUpvoted = 0
    @tip.hasUserDownvoted = 0
    helpful = HelpfulVote.select('vote').where(tip_id: @tip.id).where(user_id: current_user.id).first
    unless helpful.nil?
      case helpful.vote
      when 1
        @tip.hasUserUpvoted = 1
      when -1
        @tip.hasUserDownvoted = 1
      end
    end

    @tipDivId = "portal-tip-wrapper-#{params[:tipId]}"

    respond_to do |format|
      format.js {}
    end
  end

  def delete
    # prevent unauthorized deletions
    unless logged_in?
      flash[:alert] = 'You are not authorized to delete this post!'
      redirect_to root_path and return
    end

    tip = Tip.find params[:id]

    if tip.nil?
      flash[:alert] = 'Post not found, error deleting!'
      redirect_to root_path and return
    elsif (tip.user_id != current_user.id) && !current_user.admin
      flash[:alert] = 'You are not authorized to delete this post!'
      redirect_to root_path and return
    end
    # done checking for unauthorized deletions

    # delete helpful votes
    HelpfulVote.where(tip_id: params[:id]).destroy_all

    # delete tip
    Tip.where(id: params[:id]).destroy_all

    respond_to do |format|
      format.js {}
    end
  end
end
