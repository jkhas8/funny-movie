ruby config_generate.rb
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start config_generate: $status"
  exit $status
fi

rails db:migrate
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start db_migrate_process: $status"
  exit $status
fi

bundle exec puma -C config/puma.rb
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start puma_process: $status"
  exit $status
fi

while sleep 60; do
  ps aux |grep config_generate |grep -q -v grep
  PROCESS_1_STATUS=$?
    ps aux |grep db_migrate_process |grep -q -v grep
  PROCESS_2_STATUS=$?
  # ps aux |grep precompile |grep -q -v grep
  # PROCESS_1_STATUS=$?
  ps aux |grep puma |grep -q -v grep
  PROCESS_3_STATUS=$?
  # ps aux |grep sidekiq_process |grep -q -v grep
  # PROCESS_4_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 -o $PROCESS_3_STATUS -ne 0]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done
