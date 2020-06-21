--��ѯOracle����ִ�е�sql��估ִ�и������û�
SELECT b.sid oracleID,
       b.username ��¼Oracle�û���,
       b.serial#,
       spid ����ϵͳID,
       paddr,
       sql_text ����ִ�е�SQL,
       b.machine �������
FROM v$process a, v$session b, v$sqlarea c
WHERE a.addr = b.paddr
   AND b.sql_hash_value = c.hash_value
   
--�鿴����ִ��sql�ķ����ߵķ��ų���  
SELECT OSUSER ���Ե�¼���,
       PROGRAM ��������ĳ���,
       USERNAME ��¼ϵͳ���û���,
       SCHEMANAME,
       B.Cpu_Time ����cpu��ʱ��,
       STATUS,
       B.SQL_TEXT ִ�е�sql
FROM V$SESSION A
LEFT JOIN V$SQL B ON A.SQL_ADDRESS = B.ADDRESS
                   AND A.SQL_HASH_VALUE = B.HASH_VALUE
ORDER BY b.cpu_time DESC


--���oracle��ǰ�ı�������
SELECT l.session_id sid,
       s.serial#,
       l.locked_mode ��ģʽ,
       l.oracle_username ��¼�û�,
       l.os_user_name ��¼�����û���,
       s.machine ������,
       s.terminal �ն��û���,
       o.object_name ����������,
       s.logon_time ��¼���ݿ�ʱ��
FROM v$locked_object l, all_objects o, v$session s
WHERE l.object_id = o.object_id
   AND l.session_id = s.sid
ORDER BY sid, s.serial#
      
--���������
alter system kill session 'sid,serial#';
