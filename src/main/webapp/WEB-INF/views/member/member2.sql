show tables;

create table member2(
	idx		int not null auto_increment primary key,
	mid		varchar(60) not null,
	pwd		varchar(100) not null,
	name	varchar(20) not null,
	email	varchar(60),
	tel		varchar(13),
	pr		text,
	userInfor char(3) default '공개',
	userDel char(2) default 'NO',
	post int default 0,
	follow int default 0,
	follower int default 0,
	unique(mid)
);
drop table member2;

select * from member2 order by idx desc limit 0,5;

desc member2;
select * from member2;

create table IDPhoto(
	idx 			int not null auto_increment,	/*프로필이미지 idx*/
	userMid			varchar(60) not null,			/*해당 유저의 mid*/
	IDPhotofName	varchar(200) not null,			/*유저프로필사진의 이미지명*/
	IDPhotofSName	varchar(200) not null,			/*서버에 저장된 유저프로필사진의 이미지명 */
	primary key(idx),
	foreign key(userMid) references member2(mid)
	on update cascade							/* 부모필드를 수정하면 함께 영향을 받는다. */
	on delete restrict	
);
drop table IDPhoto;

create table follower2(
	idx				int not null auto_increment,	/**/
	followerMid		varchar(60) not null,			/*로그인한 사용자 */
	followeeMid		varchar(60) not null,			/*그 사용자가 팔로우한 아이디들*/
	primary key(idx),
	foreign key(followerMid) references member2(mid),
	foreign key(followeeMid) references member2(mid)
	on update cascade
	on delete restrict 
);	
desc follower2;

