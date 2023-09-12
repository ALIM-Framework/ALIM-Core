export module Singleton;

import <memory>;

export {
    template<typename T>
    class Singleton {
    public:
        static T& GetInstance() {
            static T Instance;
            return Instance;
        }

        Singleton(const Singleton&) = delete;
        Singleton& operator=(const Singleton&) = delete;

        Singleton(Singleton&&) = delete;
        Singleton& operator=(const Singleton&&) = delete;
    
    protected:
        Singleton() {}
    };
}