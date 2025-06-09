# MiniOB ClickBench 性能测试

## 如何运行

* 下载 ClickBench 代码。

```
git clone https://github.com/nautaa/ClickBench.git -b miniob
```
* 下载 ClickBench 数据集并解压。由于 ClickBench 数据集较大，我们只取部分数据集（前 100w 行）进行测试。

```
wget --no-verbose --continue 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
gzip -d -f hits.tsv.gz
head -n 1000000 hits.tsv > tmp.csv
```
* 运行 ClickBench。
* 
```
cd miniob/
./benchmark.sh ~/miniob/build_release/bin/ /tmp/miniob.sock /data/clickdata/tmp.csv
```
