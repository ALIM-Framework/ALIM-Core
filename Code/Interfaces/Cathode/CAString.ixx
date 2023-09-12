export module CAString;

namespace ALIM::CATHODE {
    class EntityVariableInterface {
    protected:
        virtual bool get_bool() = 0;
        virtual int get_int() = 0;
        virtual void get_string(void* out_str) = 0;
        virtual void get_FilePath(void* out_fp) = 0;
        virtual void get_SplineData() =0;
    };
}