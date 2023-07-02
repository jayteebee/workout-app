Rails.application.routes.draw do
  get 'session_logs/index'
  get 'session_logs/show'
  get 'session_logs/create'
  get 'session_logs/update'
  get 'session_logs/destroy'
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
  resources :workout_days



  resources :workout_schedules
get "user/:id/workout_schedules", to: "workout_schedules#user_schedules"


resources :workout_session
resources :exercise_session

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
