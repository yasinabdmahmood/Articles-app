class PagesController < ApplicationController
  skip_before_action :set_user_cookie_and_sessioon, only: [:home, :history, :analytics]

  def home
  end

  def history
  end

  def analytics
  end

  def search
    query = params[:text].to_s.strip

    create_search_log(query.downcase)

    if query.present?
      @articles = Article.where("title ILIKE ? OR content ILIKE ?", "%#{query}%", "%#{query}%")
    else
      @articles = []
    end

    render json: @articles
  end

  def getHistory
      search_logs = SearchLog.includes(:search)
      .where(user: current_user)

      result = search_logs.map do |log|
      {
      id: log.id,
      text: log.search.text,
      searched_at: log.created_at,
      user_id: log.user_id,
      }
      end

      render json: { result: result }, status: :ok


  end

  def getAnalytics
    searches = Search.all.order(count: :desc).limit(1000)

    render json: {
      searches: searches.map do |search|  
        {
          text: search.text,
          count: search.count,
        }
      end
    }, status: :ok
  end
 private
  def create_search_log(text)
    # Check if the text is prefex of previous search
    previous_search = SearchLog.where(user: current_user, session: current_session)

    previous_search.each do |search_log|
      if search_log.search.text.start_with?(text) 
        return
      else
        if text.start_with?(search_log.search.text) 
          search_log.destroy
          # If the text is a prefix of a previous search, destroy the previous search log
        end
      end
    end


    # Check if the search text exist in database
    search = Search.find_by(text: text)
    if search.nil?
      # If not, create a new search record
      search = Search.create(text: text, count: 0)
    end

    # Create a new search log record
    search_log = SearchLog.create(user: current_user, session: current_session, search: search)
    # Increment the search count
    search.increment!(:count)

 
  end
end
