Dir.glob('scripts/**') do |path|
  require_relative path
end
