module Ruboty
  module Handlers
    class Hello < Base
      on(/hello/i, name: "hello", description: "こんにちは")

      def hello(message)
        message.reply("Hello!!")
      end
    end
  end
end
