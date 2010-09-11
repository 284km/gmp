# do ccmt for every conceivable configuration
#
# This one is for the MacBook, running OS X 10.6

puts "In case you were wondering, this ruby is #{RUBY_VERSION}"
sleep 1

["", "--no-mpfr"].each do |no_mpfr|
  %w(1.8.7 1.9.1 1.9.2).each do |ruby_v|
    ["5.0.1 3.0.0", "4.3.2 2.4.2"].each do |gmp_mpfr|
      system("./ccmt.sh #{no_mpfr} #{ruby_v} #{gmp_mpfr} | " +
             "tee ../results-test-#{ruby_v}-" +
             "#{no_mpfr!='' ? gmp_mpfr.sub(/ .*/, '') : gmp_mpfr.sub(/ /, '-')}")
      if ARGV[0] == "--benchmark"
        Dir.chdir('../benchmark')
        system("LIBS=-lgmp ./runbench -n | " +
               "tee ../results-benchmark-#{ruby_v}-" +
               "#{no_mpfr!='' ? gmp_mpfr.sub(/ .*/, '') : gmp_mpfr.sub(/ /, '-')}")
        Dir.chdir('../ext')
      else
        sleep 1
      end
    end
  end
end
