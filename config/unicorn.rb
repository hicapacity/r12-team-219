root = "/home/deployer/sites/nexus/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/nexus.log"
stdout_path "#{root}/log/nexus.log"

listen "/tmp/unicorn.nexus.sock"
worker_processes 2
timeout 30
