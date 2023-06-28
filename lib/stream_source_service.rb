require 'date'

class StreamSourceService
  def initialize(stream)
    @stream = stream.dup
  end

  def prepare
    parse_dates!
    self
  end

  def provide
    stream
  end

  private

  def parse_dates!
    stream.each { |event| event[:date] = Date.parse(event[:date]) }
  end

  attr_reader :stream
end