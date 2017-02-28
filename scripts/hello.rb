module Ruboty
  module Handlers
    class Hello < Base
      on(/hello/i, name: "hello", description: "挨拶します")

      def hello(message)
        msg  = "こんにちは！"
        message.reply(msg)
      end
    end
  end
end
