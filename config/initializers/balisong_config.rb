BALISONG = YAML.load(File.open(File.join(Rails.root, "config/balisong.yml")))
Rails.logger.info "Loaded config from balisong.yml: #{BALISONG.pretty_inspect}"
