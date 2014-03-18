class Version
  def self.major
    0
  end

  def self.minor
    0
  end

  def self.patch 
    0
  end

  def self.build
    ENV['BUILD_NUMBER'] || "?"
  end

  def self.as_string
    "#{self.major}.#{self.minor}.#{self.patch}+#{self.build}"
  end

end
