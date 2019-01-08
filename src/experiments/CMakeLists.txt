add_executable( hash_set_experiment datastructures/set/hash_set_experiment.cpp )
add_executable( hash_bitweaving_experiment datastructures/common/bitweaving_h_store_experiment.cpp )
add_executable( vertical_bitpacking algorithms/compression/physical/bitpacking_experiment.cpp
        BenchmarkFramework/datagen/BinomialDistribution.cpp
        BenchmarkFramework/datagen/CompositeDistribution.cpp
        BenchmarkFramework/datagen/ConstantDistribution.cpp
        BenchmarkFramework/datagen/UniformDistributionBw.cpp
        BenchmarkFramework/general/utils.cpp
        BenchmarkFramework/general/buffers.cpp
        BenchmarkFramework/datagen/ComplexDataGenerator.cpp
        )
