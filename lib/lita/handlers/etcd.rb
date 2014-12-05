module Lita
  module Handlers
    class Etcd < Handler
    end

    Lita.register_handler(Etcd)
  end
end
