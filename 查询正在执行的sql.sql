--查询Oracle正在执行的sql语句及执行该语句的用户
SELECT b.sid oracleID,
       b.username 登录Oracle用户名,
       b.serial#,
       spid 操作系统ID,
       paddr,
       sql_text 正在执行的SQL,
       b.machine 计算机名
FROM v$process a, v$session b, v$sqlarea c
WHERE a.addr = b.paddr
   AND b.sql_hash_value = c.hash_value
   
--查看正在执行sql的发起者的发放程序  
SELECT OSUSER 电脑登录身份,
       PROGRAM 发起请求的程序,
       USERNAME 登录系统的用户名,
       SCHEMANAME,
       B.Cpu_Time 花费cpu的时间,
       STATUS,
       B.SQL_TEXT 执行的sql
FROM V$SESSION A
LEFT JOIN V$SQL B ON A.SQL_ADDRESS = B.ADDRESS
                   AND A.SQL_HASH_VALUE = B.HASH_VALUE
ORDER BY b.cpu_time DESC


--查出oracle当前的被锁对象
SELECT l.session_id sid,
       s.serial#,
       l.locked_mode 锁模式,
       l.oracle_username 登录用户,
       l.os_user_name 登录机器用户名,
       s.machine 机器名,
       s.terminal 终端用户名,
       o.object_name 被锁对象名,
       s.logon_time 登录数据库时间
FROM v$locked_object l, all_objects o, v$session s
WHERE l.object_id = o.object_id
   AND l.session_id = s.sid
ORDER BY sid, s.serial#
      
--解除锁命令
alter system kill session 'sid,serial#';
