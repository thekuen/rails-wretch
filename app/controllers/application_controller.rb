class ApplicationController < ActionController::Base
  def not_found
    render file: Rails.root.join('public','404.html'), 
           status: 404,
           layout: false
  end

  rescue_from ActiveRecord::RecordNotFound,with: :not_found

  helper_method :user_signed_in?, :current_user


  private

  def authenticate_user!
   if not user_signed_in?
       redirect_to login_users_path, notice: '請先登入會員'
   end
  end


  def user_signed_in?
    session[:abcd].present?
  end

  def current_user
    if user_signed_in?
   # 記憶 降低重複存取的情況  不用重複找id。 使用@_user_實體變數暫時去儲存id: session[:abcd]
   #@_user_ = @_user_ || User.find_by(id: session[:abcd])     
      
     if @_user_ 
      @_user_ =  @_user_
     else  
      @_user_ = User.find_by(id: session[:abcd])       
     end       
    
    else
      nil
    end
  end



end
