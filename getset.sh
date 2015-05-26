class=$1
type=$2
name=$3
class_filec="src/$1"
class_fileh="inc/$1"
class_filec+=".cpp"
class_fileh+=".hpp"
echo $class_file
echo "" >> src/$class.cpp
echo $2 >> src/$class.cpp
echo "$class::get$name(void) const
{
	return (this->_$name);
}" >> src/$class.cpp

echo "" >> src/$class.cpp
echo "void" >> src/$class.cpp
echo "$class::set$name($type const $name)
{
	this->_$name = $name;
	return ;
}" >> src/$class.cpp
sed -i '.tmp' $'/private:/ i\
\\\t\t'"$2 "'get'"$3"'(void)'" const;
" inc/$1.hpp
sed -i '.tmp' $'/private:/ i\
\\\t\t'"void "'set'"$3($2 const $3);\\
\\
"  inc/$1.hpp
sed -i '.tmp' $'/private:/ a\
\\\t\t'"$2"$'\\\t'"_$3;\\
\\
"  inc/$1.hpp


rm -rf $1.hpp.tmp
