dev_env = ["development", "test"]
if dev_env.include? ENV["RAILS_ENV"]
  require "dotenv"
  Dotenv.load(".env.#{ENV["RAILS_ENV"]}")
else
  require "dotenv/load"
end
