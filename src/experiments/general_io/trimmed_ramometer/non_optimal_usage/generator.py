import os
import copy


class Implementation:
    def __init__(self, impl=None):
        if impl is None:
            self.impl_lines = []
        else:
            self.impl_lines = [impl]

    def add_impl(self, impl):
        for impl_line in impl.impl_lines:
            self.impl_lines.append(impl_line)

    def add_cline(self, line):
        self.impl_lines.append("   " + line)

    def add_prgma(self, line):
        self.impl_lines.append(line)

    def get_implementation(self):
        result = ""
        for line in self.impl_lines:
            result += line + "\n"
        return result


def create_impl(impl):
    result = Implementation()
    for line in impl:
        result.add_cline(line)
    return result


class Parameter:
    def __init__(self, type, name):
        self.type = type
        self.name = name


class MethodSpecs:
    def __init__(self, return_type, name, params):
        self.return_type = return_type
        self.name = name
        self.params = params

    def add_param(self, param):
        self.params.append(param)


class Method:
    def __init__(self, method_specs):
        self.return_type = method_specs.return_type
        self.name = method_specs.name
        self.params = method_specs.params
        self.impl = None

    def set_impl(self, impl):
        self.impl = impl

    def add_param(self, param):
        self.params.append( param )

    def get_head(self):
        result = (
            self.return_type + " " +
            self.name + "( "
        )
        if len(self.params)>0:
            result += self.params[0].type + " " + self.params[0].name
            if len(self.params)>1:
                for i in range(1,len(self.params)):
                    result += ", " + self.params[i].type + " " + self.params[i].name
            result += " )"
        return result

    def get_declaration(self):
        result = (
            self.get_head() + ";\n"
        )
        return result

    def get_definition(self):
        result = (
            self.get_head() + " {\n" +
            self.impl.get_implementation() +
            "}\n"
        )
        return result


class Test:
    def __init__(self, method_specs, init_impl, actual_test_impl, return_impl, identifier):
        self.return_type = method_specs.return_type
        self.name = "test_" + method_specs.name
        self.params = method_specs.params
        self.params.append(Parameter("size_t const", "p_operator_repetitions"))
        self.impl = Implementation()
        self.impl.add_impl(init_impl)
        self.impl.add_cline("uint64_t start = get_user_clock( );")
        self.impl.add_cline("for( size_t i = 0; i < p_operator_repetitions; ++i ) {")
        self.impl.add_impl(actual_test_impl)
        self.impl.add_cline("}")
        self.impl.add_cline("uint64_t end = get_user_clock( );")
        self.impl.add_cline("double duration = get_user_time_s( start, end );")
        self.impl.add_cline(
            "std::cout << \"" +
            identifier +
            ";\" << p_length << \";\" << p_operator_repetitions " +
            "<< \";\" << duration << \";\" << duration / ( ( double ) p_operator_repetitions ) << \"\\n\";\n"
        )
        self.impl.add_impl(return_impl)

    def get_head(self):
        result = (
            self.return_type + " " +
            self.name + "( "
        )
        if len(self.params)>0:
            result += self.params[0].type + " " + self.params[0].name
            if len(self.params)>1:
                for i in range(1,len(self.params)):
                    result += ", " + self.params[i].type + " " + self.params[i].name
            result += " )"
        return result

    def get_declaration(self):
        result = (
            self.get_head() + ";\n"
        )
        return result

    def get_definition(self):
        result = (
            self.get_head() + " {\n" +
            self.impl.get_implementation() +
            "}\n"
        )
        return result


class CppFile:
    def __init__(self, fname, std_headers, custom_headers, is_main=False, is_header_only=False, defines=None):
        self.fname = fname
        self.header_name = fname + ".hpp"
        self.impl_name = fname + ".cpp"
        self.std_headers = std_headers
        self.custom_headers = custom_headers
        self.methods = []
        self.base_path = "./generated"
        self.header_rel_path = "include"
        self.header_path = self.base_path + "/" + self.header_rel_path
        self.header_abs_path = self.header_path + "/" + self.header_name
        self.impl_abs_path = self.base_path + "/" + self.impl_name
        self.preprocessor_guard = self.header_rel_path.upper() + "_" + fname.upper() + "_HPP"
        self.is_main = is_main
        self.is_header_only = is_header_only
        if defines is not None:
            self.defines = defines
        else:
            self.defines = []

        if not os.path.exists(self.header_path):
            os.makedirs(self.header_path)

    def add_method(self, method):
        self.methods.append(method)

    def write(self):
        if not self.is_main:
            with open(self.header_abs_path, "w+") as header:
                header.write(
                    "#ifndef " + self.preprocessor_guard + "\n" +
                    "#define " + self.preprocessor_guard + "\n"
                )
                for std_header in self.std_headers:
                    header.write(
                        "#include <" + std_header + ">\n"
                    )
                for custom_header in self.custom_headers:
                    header.write(
                        "#include \"" + custom_header + ".hpp\"\n"
                    )
                for define in self.defines:
                    header.write(
                        "#define " + define + "\n"
                    )
                for method in self.methods:
                    if not self.is_header_only:
                        header.write(
                            method.get_declaration()
                        )
                    else:
                        header.write(
                            method.get_definition()
                        )
                header.write(
                    "#endif\n"
                )
        if not self.is_header_only:
            with open(self.impl_abs_path, "w+") as impl:
                if not self.is_main:
                    impl.write(
                        "#include \"" + self.header_rel_path + "/" + self.header_name + "\"\n\n"
                    )
                else:
                    for std_header in self.std_headers:
                        impl.write(
                            "#include <" + std_header + ">\n"
                        )
                    for custom_header in self.custom_headers:
                        impl.write(
                            "#include \"" + self.header_rel_path + "/" + custom_header + ".hpp\"\n"
                        )
                    for define in self.defines:
                        impl.write(
                            "#define " + define + "\n"
                        )
                for method in self.methods:
                    impl.write(
                        method.get_definition()
                    )


class Variant32:
    def __init__(self):
        self.data_type = "uint32_t"
        self.data_c_type = "uint32_t const"
        self.has_vector_pragma = True
        self.vector_pragma = "#pragma _NEC packed_vector"
        self.pointer_cc_type = "uint32_t const * const"
        self.pointer_c_type = "uint32_t * const"
        self.pointer_type = "uint32_t *"
        self.vector_count = "512"
        self.suffix = "_32bit"
        self.bw = "32"
        self.loop_width_upperbound = 513


class Variant64:
    def __init__(self):
        self.data_type = "uint64_t"
        self.data_c_type = "uint64_t const"
        self.has_vector_pragma = False
        self.vector_pragma = ""
        self.pointer_cc_type = "uint64_t const * const"
        self.pointer_c_type = "uint64_t * const"
        self.pointer_type = "uint64_t *"
        self.vector_count = "256"
        self.suffix = "_64bit"
        self.bw = "64"
        self.loop_width_upperbound = 257


def construct_read(variants, read_fname):
    operator_name = "read"
    result = []
    for variant in variants:
        read_file = CppFile(
            read_fname + variant.suffix,
            ["cstddef", "cstdint"],
            ["utils"]
        )
        read_test_file = CppFile(
            "test_" + read_fname + variant.suffix,
            ["cstddef", "cstdint","ctime", "iostream"],
            [read_fname + variant.suffix]
        )
        for loop_width in range(1,variant.loop_width_upperbound):
            specs = MethodSpecs(
                variant.data_type,
                operator_name + variant.suffix + "_" + str(loop_width),
                [Parameter(variant.pointer_cc_type, "p_data"), Parameter("size_t const", "p_length")]
            )
            method = Method(
                specs
            )
            impl = Implementation()
            impl.add_cline(variant.data_type + " result_array[ " + variant.vector_count + " ];")
            impl.add_cline(variant.data_type + " result = 0;")
            impl.add_cline("size_t length = p_length / " + str(loop_width) + ";")
            impl.add_prgma("#pragma _NEC vreg( result_array )")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("for( size_t i = 0; i < " + variant.vector_count + "; ++i ) {")
            impl.add_cline("   result_array[ i ] = 0;")
            impl.add_cline("}")
            impl.add_prgma("#pragma _NEC noouterloop_unroll")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("for( size_t outer = 0; outer < length; outer += " + str(loop_width) + " ) {")
            impl.add_prgma("#pragma _NEC shortloop")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("   for( size_t inner = 0; inner < " + str(loop_width) + "; ++inner ) {")
            impl.add_cline("      result_array[ inner ] |= p_data[ outer + inner ];")
            impl.add_cline("   }")
            impl.add_cline("}")
            impl.add_cline("for( size_t aggr = 0; aggr < " + variant.vector_count + "; ++aggr ) {")
            impl.add_cline("   result |= result_array[ aggr ];")
            impl.add_cline("}")
            impl.add_cline("for( size_t i = length; i < p_length; ++i ) {")
            impl.add_cline("   result |= p_data[ i ];")
            impl.add_cline("}")
            impl.add_cline("return result;")
            method.set_impl(impl)
            read_file.add_method(
                method
            )
            read_file.write()

            test = Test(
                copy.deepcopy(specs),
                Implementation(
                    "   " +variant.data_type + " result = " + operator_name + variant.suffix + "_" + str(loop_width) + "( " +
                    "p_data, p_length );"
                ),
                Implementation(
                    "      result |= " + operator_name + variant.suffix + "_" + str(loop_width) +
                    "( p_data, p_length );"
                ),
                Implementation("   return result;"),
                "Read;" + variant.bw + ";"+ str(loop_width)
            )
            read_test_file.add_method(test)
            read_test_file.write()
            result.append(read_test_file)
    return result


def construct_copy(variants, copy_fname):
    operator_name = "copy"
    result = []
    for variant in variants:
        copy_file = CppFile(
            copy_fname + variant.suffix,
            ["cstddef", "cstdint"],
            ["utils"]
        )
        copy_test_file = CppFile(
            "test_" + copy_fname + variant.suffix,
            ["cstddef", "cstdint","ctime", "iostream"],
            [copy_fname + variant.suffix]
        )
        for loop_width in range(1,variant.loop_width_upperbound):
            specs = MethodSpecs(
                variant.data_type,
                operator_name + variant.suffix + "_" + str(loop_width),
                [
                    Parameter(variant.pointer_cc_type, "p_data"),
                    Parameter("size_t const", "p_length"),
                    Parameter(variant.pointer_c_type, "p_out"),
                ]
            )
            impl_specs = copy.deepcopy(specs)
            impl_specs.add_param( Parameter("size_t const", "p_dummy") )

            method = Method(
                impl_specs
            )
            impl = Implementation()
            impl.add_cline("size_t length = p_length / " + str(loop_width) + ";")
            impl.add_cline("size_t remainder = p_length % " + str(loop_width) + ";")
            impl.add_prgma("#pragma _NEC noouterloop_unroll")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("for( size_t outer = 0; outer < length; outer += " + str(loop_width) + " ) {")
            impl.add_cline("   size_t inner_upper_bound = outer + " + str(loop_width) + ";")
            impl.add_prgma("#pragma _NEC shortloop")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("   for( size_t inner = outer; inner < inner_upper_bound; ++inner ) {")
            impl.add_cline("      p_out[ inner ] = p_data[ inner ];")
            impl.add_cline("   }")
            impl.add_cline("}")
            impl.add_cline("for( size_t i = length; i < p_length; ++i ) {")
            impl.add_cline("   p_out[ i ] = p_data[ i ];")
            impl.add_cline("}")
            impl.add_cline("return p_out[ p_dummy ];")
            method.set_impl(impl)
            copy_file.add_method(
                method
            )
            copy_file.write()

            test = Test(
                specs,
                create_impl(
                    [
                        "srand( time( NULL ) );",
                        "size_t dummy = rand( ) % p_length;",
                        variant.data_type + " result = " + operator_name + variant.suffix + "_" + str(
                            loop_width) + "( " +
                        "p_data, p_length, p_out, dummy );"
                    ]
                ),
                Implementation(
                    "      result |= " + operator_name + variant.suffix + "_" + str(loop_width) +
                    "( p_data, p_length, p_out, dummy );"
                ),
                Implementation("   return result;"),
                "Copy;" + variant.bw + ";" + str(loop_width)
            )
            copy_test_file.add_method(test)
            copy_test_file.write()
            result.append(copy_test_file)
    return result


def construct_write(variants, write_fname):
    operator_name = "write"
    result = []
    for variant in variants:
        write_file = CppFile(
            write_fname + variant.suffix,
            ["cstddef", "cstdint"],
            ["utils"]
        )
        write_test_file = CppFile(
            "test_" + write_fname + variant.suffix,
            ["cstddef", "cstdint","ctime", "iostream"],
            [write_fname + variant.suffix]
        )
        for loop_width in range(1, variant.loop_width_upperbound):
            specs = MethodSpecs(
                variant.data_type,
                operator_name + variant.suffix + "_" + str(loop_width),
                [
                    Parameter(variant.pointer_c_type, "p_out"),
                    Parameter("size_t const", "p_length"),
                    Parameter(variant.data_c_type, "p_val"),
                ]
            )
            impl_specs = copy.deepcopy(specs)
            impl_specs.add_param( Parameter("size_t const", "p_dummy") )

            method = Method(
                impl_specs
            )
            impl = Implementation()
            impl.add_cline(variant.data_type + " val[ " + variant.vector_count + " ];")
            impl.add_cline("size_t length = p_length / " + str(loop_width) + ";")
            impl.add_prgma("#pragma _NEC vreg( val )")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("for( size_t i = 0; i < " + variant.vector_count + "; ++i ) {")
            impl.add_cline("   val[ i ] = p_val;")
            impl.add_cline("}")
            impl.add_prgma("#pragma _NEC noouterloop_unroll")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("for( size_t outer = 0; outer < length; outer += " + str(loop_width) + " ) {")
            impl.add_prgma("#pragma _NEC shortloop")
            if variant.has_vector_pragma:
                impl.add_prgma(variant.vector_pragma)
            impl.add_cline("   for( size_t inner = outer; inner < " + str(loop_width) + "; ++inner ) {")
            impl.add_cline("      p_out[ outer + inner ] = val[ inner ];")
            impl.add_cline("   }")
            impl.add_cline("}")
            impl.add_cline("for( size_t i = length; i < p_length; ++i ) {")
            impl.add_cline("   p_out[ i ] = p_val;")
            impl.add_cline("}")
            impl.add_cline("return p_out[ p_dummy ];")
            method.set_impl(impl)
            write_file.add_method(
                method
            )
            write_file.write()

            test = Test(
                copy.deepcopy(specs),
                create_impl(
                    [
                        "srand( time( NULL ) );",
                        "size_t dummy = rand( ) % p_length;",
                        variant.data_type + " result = " + operator_name + variant.suffix + "_" + str(
                            loop_width) + "( " +
                        "p_out, p_length, p_val, dummy );"
                    ]
                ),
                Implementation(
                    "      result |= " + operator_name + variant.suffix + "_" + str(loop_width) +
                    "( p_out, p_length, p_val, dummy );"
                ),
                Implementation("   return result;"),
                "Write;" + variant.bw + ";" + str(loop_width)
            )
            write_test_file.add_method(test)
            write_test_file.write()
            result.append(write_test_file)
    return result

variants = [
	#Variant32(),
	Variant64()
]

tests = [
    construct_read(variants, "read"),
    construct_copy(variants, "copy"),
    construct_write(variants, "write")
]

general_test_headers = ["utils"]
for test in tests:
    for vartest in test:
        general_test_headers.append(vartest.fname)

test_headers = ["utils"]
for variant in variants:
    operator_name = "measurement"
    measurement_file = CppFile(
        operator_name + variant.suffix,
        ["cstddef", "cstdint","ctime", "iostream"],
        general_test_headers
    )
    specs = MethodSpecs(
        "void",
        operator_name + variant.suffix,
        [
            Parameter(variant.pointer_c_type, "p_in"),
            Parameter(variant.pointer_c_type, "p_out"),
            Parameter("size_t const", "p_length"),
            Parameter("size_t const", "p_test_repetitions"),
            Parameter("size_t const", "p_operator_repetitions"),
        ]
    )
    method = Method(
        specs
    )
    impl = Implementation()
    impl.add_cline("srand( time( NULL ) );")
    impl.add_cline(variant.data_type + " result = rand( ) ;")
    for loop_width in range(1, variant.loop_width_upperbound):
        impl.add_cline("std::cerr << \"Test " + variant.bw + " Bit with LoopWidth = " + str(loop_width) + "...\";\n")
        impl.add_cline("for(size_t i = 0; i < p_test_repetitions; ++i) {")
        impl.add_cline("   std:: cout << i << \";\";")
        impl.add_cline("   result |= test_write" + variant.suffix + "_" + str(loop_width) +
                       "(p_in, p_length, result, p_operator_repetitions);")
        impl.add_cline("   std::cout << i << \";\";")
        impl.add_cline("   result |= test_copy" + variant.suffix + "_" + str(loop_width) +
                       "(p_in, p_length, p_out, p_operator_repetitions);")
        impl.add_cline("   std::cout << i << \";\";")
        impl.add_cline("   result |= test_read" + variant.suffix + "_" + str(loop_width) +
                       "(p_out, p_length, p_operator_repetitions);")
        impl.add_cline("}")
        impl.add_cline("std::cerr << \"Done. Dummy Result = \" << (unsigned) result << \"\\n\";")

    method.set_impl(impl)
    measurement_file.add_method(
        method
    )
    measurement_file.write()
    test_headers.append(measurement_file.fname)


main_file = CppFile(
    "main",
    [
        "cstddef",
        "cstdint",
        "ctime",
        "vector",
        "iostream",
        "fstream",
        "string"
    ],
    test_headers,
    True,
    False,
    [
        "ALIGNMENT 128",
        "ALIGNMENT_MINUS_ONE ALIGNMENT-1",
        "ALIGNMENT_TWOS_COMPLEMENT -ALIGNMENT",
        "KB16 16384",
        "KB32 32768",
        "KB512 524288",
        "MB1 1048576",
        "MB4 4194304",
        "MB8 8388608",
        "MB16 16777216",
        "MB32 33554432",
        "MB128 134217728",
        "GB1 1073741824",
        "GB4 4294967296",
        "GB8 8589934592",
    ]
)
specs = MethodSpecs(
        "int",
        "main",
        [Parameter("void", "")]
    )
method = Method(
    specs
)
impl = Implementation()
impl.add_cline("std::ofstream out(\"results.csv\");")
impl.add_cline("std::cout.rdbuf(out.rdbuf());")
impl.add_cline(
   "std::vector<uint64_t> buffer_size_bytes{ " +
   "KB16, KB32, KB512, MB1, MB4, MB8, MB16, MB32, MB128, GB1, GB4, GB8 };"
)
for variant in variants:
    impl.add_cline("for( uint64_t buffer_size : buffer_size_bytes ) {")
    impl.add_cline("   //Align to 128 Byte")
    impl.add_cline("   void * in_orig = malloc( buffer_size + ALIGNMENT_MINUS_ONE );")
    impl.add_cline("   size_t tmp = reinterpret_cast < size_t >( in_orig );")
    impl.add_cline(
        "   " + variant.pointer_type + " in = " +
        "reinterpret_cast< " + variant.pointer_type + " >( tmp + ALIGNMENT + " +
        "( -( tmp & ALIGNMENT_MINUS_ONE ) | ALIGNMENT_TWOS_COMPLEMENT ) );"
    )
    impl.add_cline("   void * out_orig = malloc( buffer_size + ALIGNMENT_MINUS_ONE );")
    impl.add_cline("   tmp = reinterpret_cast < size_t >( out_orig );")
    impl.add_cline(
        "   " + variant.pointer_type + " out = " +
        "reinterpret_cast< " + variant.pointer_type + " >( tmp + ALIGNMENT + " +
        "( -( tmp & ALIGNMENT_MINUS_ONE ) | ALIGNMENT_TWOS_COMPLEMENT ) );"
    )
    impl.add_cline("   size_t operator_repetitions = 1;")
    impl.add_cline("   size_t test_repetitions = 30;")
    impl.add_cline("   if( buffer_size <= MB1 )")
    impl.add_cline("      operator_repetitions = 100000;")
    impl.add_cline("   else if( buffer_size <= MB16 )")
    impl.add_cline("      operator_repetitions = 1000;")
    impl.add_cline("   else if( buffer_size < GB1 )")
    impl.add_cline("      operator_repetitions = 100;")
    impl.add_cline("   else")
    impl.add_cline("      operator_repetitions = 10;")
    impl.add_cline("   std::cerr << \"Processing \" << buffer_size << \" Byte. \";")
    impl.add_cline(
        "   measurement" + variant.suffix +
        "( in, out, buffer_size / sizeof( " + variant.data_type + " ), test_repetitions, operator_repetitions );"
    )
    impl.add_cline("   free( out_orig );")
    impl.add_cline("   free( in_orig );")
    impl.add_cline("}")
impl.add_cline("return 0;")
method.set_impl(impl)
main_file.add_method(
    method
)
main_file.write()



utils_file = CppFile(
    "utils",
    ["cstdint", "cstddef"],
    [],
    False,
    False
)

get_user_time_s_method = Method(
    MethodSpecs(
        "double",
        "get_user_time_s",
        [
            Parameter("uint64_t", "start"),
            Parameter("uint64_t", "end")
        ]
    )
)
get_user_time_s_method.set_impl(
    Implementation("return ( (double)((double)end - (double) start) ) / ( (double)(1400*1000*1000) );")
)

get_user_clock_method = Method(
    MethodSpecs(
        "uint64_t",
        "get_user_clock",
        [Parameter("void", "")]
    )
)
get_user_clock_method.set_impl(
    Implementation("asm( \"smir %s0, %usrcc\" );")
    # Implementation("return 3.0;")
)
utils_file.add_method(get_user_time_s_method)
utils_file.add_method(get_user_clock_method)
utils_file.write()

