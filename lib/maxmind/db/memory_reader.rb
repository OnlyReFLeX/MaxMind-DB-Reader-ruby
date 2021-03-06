# frozen_string_literal: true

module MaxMind # :nodoc:
  class DB
    class MemoryReader # :nodoc:
      def initialize(filename, options = {})
        if options[:is_buffer]
          @buf = filename
          @size = @buf.length
          return
        end

        @buf = File.read(filename, mode: 'rb').freeze
        @size = @buf.length
      end

      attr_reader :size

      # Override to not show @buf in inspect to avoid showing it in irb.
      def inspect
        s = "#<#{self.class.name}:0x#{self.class.object_id.to_s(16)} "
        s << '@size=' << @size.inspect << '>'
      end

      def close; end

      def read(offset, size)
        @buf[offset, size]
      end
    end
  end
end
