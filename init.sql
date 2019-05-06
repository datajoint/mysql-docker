
CREATE USER 'datajoint'@'%' IDENTIFIED BY 'datajoint';
GRANT ALL PRIVILEGES ON `djtest%`.* TO 'datajoint'@'%';

CREATE USER 'djview'@'%' IDENTIFIED BY 'djview';
grant select on `djtest%`.* to 'djview'@'%';
