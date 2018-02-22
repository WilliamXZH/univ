package com.sand.util.ReduceMapper;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.junit.Test;
import org.springframework.stereotype.Component;

@Component
public class WordCountMaster {
	public void mapReduce(String string) throws Exception {
		String url = null;
		String output = null;
		if(string.equals("pie_picture")){
			 url="hdfs://whn01:8020/user/hive/warehouse/mytest.db/city/part-m-00000";
			 output="hdfs://whn01:8020/bigdataout/sqoop/hive/pie";
		}else if(string.equals("line_picture")){
			url="hdfs://whn01:8020/user/hive/warehouse/mytest.db/time/part-m-00000";
			output="hdfs://whn01:8020/bigdataout/sqoop/hive/line";
		}else if(string.equals("map_picture")){
			url="hdfs://whn01:8020/user/hive/warehouse/mytest.db/route/part-m-00000";
			output="hdfs://whn01:8020/bigdataout/sqoop/hive/map";
		}else{
			url="hdfs://whn01:8020/user/hive/warehouse/mytest.db/point/part-m-00000";
			output="hdfs://whn01:8020/bigdataout/sqoop/hive/point";
		}
		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "wordCount");
		job.setJarByClass(WordCountMaster.class);
		job.setMapperClass(WordCountMapper.class);
		job.setReducerClass(WordCountReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		FileInputFormat.setInputPaths(job, new Path(url));
		FileOutputFormat.setOutputPath(job, new Path(output));
		boolean result = job.waitForCompletion(true);
	}

}
