docker commands to use project:  

docker run --rm -it \
  -v "$(pwd)":/workspace \


Running the code: 

- cd /workspace/dynamorio/build

- cmake --build . --target wrap -- -j$(nproc)

- cd /workspace/dynamorio/build
export DRRUN=$PWD/bin64/drrun
export CLIENT=$PWD/api/bin/libwrap.so
export LD_LIBRARY_PATH=$PWD/lib64/release:$PWD/lib64:$LD_LIBRARY_PATH

- cd ../lab4_testcases


- $DRRUN -c $CLIENT -- ./test0

- # for all of the test files to be outputted do 
    # 1) compile every .c → testN
for src in *.c; do
  gcc -Wall -Wextra -o "${src%.c}" "$src"
done

# 2) run only the executables, one at a time, and
#    redirect each into testN.out
for bin in *; do
  # skip .c’s and skip anything non-executable
  if [[ -x "$bin" && ! "$bin" =~ \.c$ ]]; then
    echo "=== Running $bin ==="
    ../build/bin64/drrun \
      -c ../build/api/bin/libwrap.so -- \
      "./$bin" \
      > "$bin.out" 2>&1
  fi
done
