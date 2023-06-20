Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :exercises
  resources :workouts
  get '/workouts/:workout_id/exercises', to: 'workouts#exercises'
  post '/workouts/:workout_id/exercises', to: 'workouts#add_exercise'
  put '/workouts/:workout_id/exercises/:exercise_id', to: 'workouts#update_exercise'
  delete '/workouts/:workout_id/exercises/:exercise_id', to: 'workouts#delete_exercise'


  resources :routines
get '/routines/:routine_id/workouts', to: 'routines#workouts'
put '/routines/:routine_id/workouts', to: 'routines#add_workout'
delete '/routines/:routine_id/workouts/:workout_id', to: 'routines#delete_workout'

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
