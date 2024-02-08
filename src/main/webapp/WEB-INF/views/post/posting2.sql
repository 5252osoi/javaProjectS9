show tables;
/*게시글*/
create table posting2 (
	idx		int not null auto_increment,	/*게시글고유번호*/
	mid		varchar(60) not null,			/*글쓴이(세션아이디)*/
	FName	varchar(200) not null,			/*업로드시 파일명*/
	FSName	varchar(200) not null,			/*서버 저장시 파일명*/
	FSize	int not null,					/*업로드 한 파일사이즈*/
	content text not null,					/*글 내용*/
	hostIp	varchar(50) not null,			/*작성자IP*/
	openSw	char(6) default	'공개',			/*게시글 공개설정*/
	likes	int default 0,					/*좋아요 수*/
	reply	int default 0,					/*댓글 수*/
	WDate	datetime default now(),			/*작성일*/
	foreign key(mid) references member2(mid),
	primary key(idx)
);
desc posting2;
select * from posting2 order by idx desc;
drop table posting2;

/* 게시판에 댓글 달기 */
create table postReply2 (
	idx     	int not null auto_increment,	/* 댓글의 고유번호 */
	postIdx		int not null,					/* 원본글(부모글)의 고유번호(외래키로 설정) */
	mid			varchar(30) not null,			/* 댓글 올린이의 아이디 */
	hostIp		varchar(50) not null,			/* 댓글 올린 PC의 고유 IP */
	content		text not null,					/* 댓글 내용 */  
	WDate		datetime default now(),			/* 댓글 올린 날짜 */
	likes		int default 0,
	primary key(idx),
	foreign key(postIdx) references posting2(idx),
	foreign key(mid) references member2(mid)
	on update cascade							/* 부모필드를 수정하면 함께 영향을 받는다. */
	on delete restrict							/* 부모필드를 함부로 삭제할수 없다. */
);
desc postReply2;
drop table postReply2;  

/* 게시글에 좋아요 만들기*/
create table postLike2 (
	idx int not null auto_increment,			/*좋아요idx*/
	postIdx int not null,						/*게시글의idx*/
	mid varchar(30) not null,					/*좋아요 누른 유저 ID*/
	replyIdx int default null,					/*댓글의idx*/
	primary key(idx),
	unique key(postIdx,mid),
	foreign key(postIdx) references posting2(idx),
	foreign key(mid) references member2(mid)
	on update cascade							/* 부모필드를 수정하면 함께 영향을 받는다. */
	on delete restrict	
);
desc postLike2;
drop table postLike2;

/*posting테이블의 likes=해당하는 postIDX를 가지고있는postlike테이블의 데이터 수*/
UPDATE posting p
SET p.likes = (
    SELECT COUNT(l.idx)
    FROM postlike l
    WHERE l.postIdx = p.idx
);

/*게시글 5개를 가져갈 때 해당하는 게시글의 좋아요 데이터를 가져감*/
select
	p.idx as postIdx, l.mid as mid
from posting p
left join postLike l
on p.idx = l.postIdx
and l.mid = /*로그인된아이디*/
order by p.idx desc limit ?,?;

/* 게시글에 달린 댓글을 가져오는 sql문 */
/* 스크롤을 내릴 때 로딩해서 최대 5개까지 게시글을 가져오고 */
/* 그 게시글에 달려있는 모든 댓글들을 가져와야함 */
select
    postReply.idx,
    postReply.postIdx,
    postReply.mid,
    postReply.hostIp,
    postReply.content,
    postReply.likes,
    postReply.wDate
from postReply
left join posting on postReply.postIdx = posting.idx
/* posting이 있는 경우에만 결과에 포함 */
where posting.idx in not null  
order by posting.idx desc, postReply.idx
limit 0,5;
/*이렇게하면 글도 5개, 댓글도 5개까지밖에 안나옴 ㅋㅋ */



select 
	postReply.idx,
	postReply.postIdx,
	postReply.mid,
	postReply.hostIp,
	postReply.content,
	postReply.likes,
	postReply.wDate
from postReply
left join posting on postReply.postIdx = posting.idx 
where posting.idx in (?) ;				/*글이 1개일때*/
where posting.idx in (?, ?);			/*글이 2개일때*/
where posting.idx in (?, ?, ?);			/*글이 3개일때*/
where posting.idx in (?, ?, ?, ?);		/*글이 4개일때*/
where posting.idx in (?, ?, ?, ?, ?);	/*글이 5개일때*/
order by posting.idx, postReply.idx;
/*해당 글에 딸린 모든 댓글을 가져오려면 이렇게 해야함.. */
/*근데 그러면 where부분에서 SQL문이 계속 바뀐다*/
