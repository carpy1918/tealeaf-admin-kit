require 'facter'

  Facter.add('datestr') do
    setcode "date +%m%d%Y"
  end
