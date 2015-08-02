require 'facter'

  Facter.add('timezone') do
    setcode "date +%Z"
  end
