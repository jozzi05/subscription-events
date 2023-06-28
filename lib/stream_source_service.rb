class StreamSourceService
  def initialize(stream)
    @stream = stream.dup
  end

  def prepare
    self
  end

  def provide
    stream
  end

  private

  attr_reader :stream
end