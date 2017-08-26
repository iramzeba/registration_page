Rails.application.routes.draw do
   devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" } 
 get 'auth/:provider/callback', to: 'users#facebook'
resources :users do 
  	collection do 
       get 'sign_in'
       post 'signup'
       delete 'logout'
       get 'forget_password'
       post 'recover_password'
    
       get 'user_profile'
  	end
  end 
  root to: "users#sign_in" 
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
