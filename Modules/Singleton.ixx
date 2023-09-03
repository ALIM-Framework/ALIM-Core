export module Singleton;

export {
    template<typename T>
    class Singleton {
    public:
        static Singleton& GetInstance() {
            static T Instance;
            return Instance;
        }

    protected:
        Singleton() {};
        ~Singleton() {};

        Singleton(const Singleton&) = delete;
        Singleton& operator=(const Singleton&) = delete;

        Singleton(Singleton&&) = delete;
        Singleton& operator=(const Singleton&&) = delete;
    };
}