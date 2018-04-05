from pyspark import SparkContext, SparkConf, SQLContext
from pyspark.sql import SparkSession

warehouseLocation="/"
spark = SparkSession.builder.appName("SparkSessionHDFSExample").config("spark.sql.warehouse.dir", warehouseLocation).enableHiveSupport().getOrCreate()

sc = spark.sparkContext
values = sc.parallelize(range(1,10))
values.saveAsTextFile("hdfs://hdfs/testfile")

#inp_file = sc.textFile("hdfs://")
print("Done")