BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "migrations" (
	"id"	integer NOT NULL,
	"migration"	varchar NOT NULL,
	"batch"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users" (
	"id"	integer NOT NULL,
	"name"	varchar NOT NULL,
	"phone"	varchar NOT NULL,
	"password"	varchar NOT NULL,
	"user_verified_at"	datetime,
	"verification_code"	integer,
	"remember_token"	varchar,
	"created_at"	datetime,
	"updated_at"	datetime,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "password_reset_tokens" (
	"email"	varchar NOT NULL,
	"token"	varchar NOT NULL,
	"created_at"	datetime,
	PRIMARY KEY("email")
);
CREATE TABLE IF NOT EXISTS "failed_jobs" (
	"id"	integer NOT NULL,
	"uuid"	varchar NOT NULL,
	"connection"	text NOT NULL,
	"queue"	text NOT NULL,
	"payload"	text NOT NULL,
	"exception"	text NOT NULL,
	"failed_at"	datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "personal_access_tokens" (
	"id"	integer NOT NULL,
	"tokenable_type"	varchar NOT NULL,
	"tokenable_id"	integer NOT NULL,
	"name"	varchar NOT NULL,
	"token"	varchar NOT NULL,
	"abilities"	text,
	"last_used_at"	datetime,
	"expires_at"	datetime,
	"created_at"	datetime,
	"updated_at"	datetime,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tags" (
	"id"	integer NOT NULL,
	"name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "posts" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"title"	varchar NOT NULL,
	"body"	varchar NOT NULL,
	"cover_image"	text NOT NULL,
	"pinned"	tinyint(1) NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"deleted_at"	datetime,
	FOREIGN KEY("user_id") REFERENCES "users"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "post_tags" (
	"id"	integer NOT NULL,
	"post_id"	integer,
	"tag_id"	integer,
	"created_at"	datetime,
	"updated_at"	datetime,
	FOREIGN KEY("post_id") REFERENCES "posts"("id") on delete set null,
	FOREIGN KEY("tag_id") REFERENCES "tags"("id") on delete set null,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "migrations" ("id","migration","batch") VALUES (1,'2014_10_12_000000_create_users_table',1),
 (2,'2014_10_12_100000_create_password_reset_tokens_table',1),
 (3,'2019_08_19_000000_create_failed_jobs_table',1),
 (4,'2019_12_14_000001_create_personal_access_tokens_table',1),
 (5,'2024_02_25_233934_create_tags_table',2),
 (12,'2024_02_26_133857_create_posts_table',3),
 (13,'2024_02_26_140244_create_post_tags_table',3);
INSERT INTO "users" ("id","name","phone","password","user_verified_at","verification_code","remember_token","created_at","updated_at") VALUES (2,'Mayada','01068039502','$2y$12$KvZzj5QW1jPG5ndA8dExTe4YPhaAEVa4G6H4RcOpcQUPNPVAEgcX6','2024-02-25 23:22:43',NULL,NULL,'2024-02-25 22:14:01','2024-02-25 23:22:43'),
 (3,'Mohamed','01007982550','$2y$12$YbLUkTuFLTAWkFvWkifV8uvOMsAN/pBg9.885Tc.TC4LpOYPgAx/S',NULL,NULL,NULL,'2024-02-25 22:15:39','2024-02-25 23:00:15'),
 (4,'Mohamed','010079825500','$2y$12$HOliCROXYFgHS23gJe9ohOS0T5rFdKeC1Nuh2X/iMCAi/5FupQHQe',NULL,171600,NULL,'2024-02-25 22:23:30','2024-02-25 22:23:31'),
 (5,'Mohamed','010079825505','$2y$12$.ze39w0S6FMDfrGp6coaQ..4Kr7UlbS3H1RCdpBd76f8sGylGqRqq',NULL,133295,NULL,'2024-02-25 22:24:18','2024-02-25 22:24:18'),
 (6,'Mohamed','0100798255058','$2y$12$2TRkpwcxSuaz50fe3KfoxueBsYo1cqjZIN0Wa0kMtl5PLafpkzG/2',NULL,621417,NULL,'2024-02-25 22:29:14','2024-02-25 22:29:14'),
 (7,'Mohamed','0100798255099','$2y$12$CtDhVE6ex9Y6zT7gcWZukuNTf23FXRHEK28ud8pAoD3xXNsaS6PMG',NULL,790893,NULL,'2024-02-25 22:30:15','2024-02-25 22:30:15'),
 (8,'Mohamed','0100798255090','$2y$12$GeL.EWwlMnNmahU6mVFKo.Jsor2WrgG6Ns8CZUbtVSjfQuLcBujKy',NULL,118764,NULL,'2024-02-25 22:32:01','2024-02-25 22:32:01'),
 (9,'Mohamed','01007982550998','$2y$12$oaNE2WvKdyAhVwXxOluROur59YsL2V7DOgjVyXVFzgFgZvVIhHiny',NULL,342726,NULL,'2024-02-25 22:32:26','2024-02-25 22:32:27'),
 (10,'New','010680395026','$2y$12$1VidMB1LFb1AdJD9gXLMEeRzifIkZ1Xm4zKEVdM3gMMK.H3s212u6','2024-02-26 22:57:25',NULL,NULL,'2024-02-26 22:46:55','2024-02-26 22:57:25'),
 (11,'New','010680395','$2y$12$kfBsG34ptj9TxWicdZ/0LO.vKDN5z5RHI3qZS0nxA.a8qWcFf.oES',NULL,358744,NULL,'2024-02-26 23:55:18','2024-02-26 23:55:18'),
 (12,'New','1234560','$2y$12$Adme9jn5Ji4X7tXzlgkG1.X.23DRXMZnYq3fZTQ0Xqjdekr9K/scy',NULL,904001,NULL,'2024-02-26 23:56:33','2024-02-26 23:56:33'),
 (13,'New','6464646','$2y$12$ZRbq5.4eHwcivODpeBkfJu3xoyYwsWy.oPNQrrq5x.SOp4/iK8ao6',NULL,783761,NULL,'2024-02-26 23:57:03','2024-02-26 23:57:03'),
 (14,'New','01234567980','$2y$12$VnVfjQnvvZsyKn1nD1Q4semu1if5iBTyrHbWFHpiHURV8samjuxRm',NULL,736403,NULL,'2024-02-26 23:57:24','2024-02-26 23:57:24');
INSERT INTO "personal_access_tokens" ("id","tokenable_type","tokenable_id","name","token","abilities","last_used_at","expires_at","created_at","updated_at") VALUES (1,'App\Models\User',1,'authToken','6ced2710c2d4b573346431e23dede041206fdbbe59f61433fc5d5ae99b6fe4ee','["*"]',NULL,NULL,'2024-02-25 22:13:18','2024-02-25 22:13:18'),
 (2,'App\Models\User',2,'authToken','26d3dd7d54d84692307f2cb7e71fdaf32a39157aac4b0eef4d063c69253fb26c','["*"]',NULL,NULL,'2024-02-25 22:14:01','2024-02-25 22:14:01'),
 (3,'App\Models\User',3,'authToken','899b6f3e491c5f602d66af39edb64da000cf841f18448d37a4b27204326cdf56','["*"]',NULL,NULL,'2024-02-25 22:15:40','2024-02-25 22:15:40'),
 (4,'App\Models\User',4,'authToken','acce3a235ddbbb2333382585644cfebb4004dfafe1c1f6d162212110eaaf2aa3','["*"]',NULL,NULL,'2024-02-25 22:23:31','2024-02-25 22:23:31'),
 (5,'App\Models\User',5,'authToken','4fd7c29d10d31fbdd409699539dd41f52d8ae81cb4aed71bc6b26bec869ce865','["*"]',NULL,NULL,'2024-02-25 22:24:18','2024-02-25 22:24:18'),
 (6,'App\Models\User',6,'authToken','6754eafca92410e6496125bb4f475e783ef1cd63545249084f1d7274e1b1a03b','["*"]',NULL,NULL,'2024-02-25 22:29:15','2024-02-25 22:29:15'),
 (7,'App\Models\User',7,'authToken','aa4333c7a6c635c8c7d153d51baf05051ad7d7175c094291ebfcc7d97ecbf3ac','["*"]',NULL,NULL,'2024-02-25 22:30:15','2024-02-25 22:30:15'),
 (8,'App\Models\User',8,'authToken','98aed9b77284183fc7c1603b60e35389b13c445463268c7bd95e478df1c948ac','["*"]',NULL,NULL,'2024-02-25 22:32:02','2024-02-25 22:32:02'),
 (9,'App\Models\User',2,'authToken','01fb2d7beb5ba28e1d842e4ef5fec2f56c2458c333e5fc73fab52ba4f28c8724','["*"]',NULL,NULL,'2024-02-25 22:33:39','2024-02-25 22:33:39'),
 (10,'App\Models\User',2,'authToken','4b92dab546dba27d4b52cec03abd0ba3123f9a69f54403e41ee0e392d831b45a','["*"]',NULL,NULL,'2024-02-25 22:34:25','2024-02-25 22:34:25'),
 (11,'App\Models\User',2,'authToken','d25d75da333bfb654d896b194d0f14c5b2ff54d2e0ed48c9b5ef9695d5fb94a3','["*"]',NULL,NULL,'2024-02-25 22:35:21','2024-02-25 22:35:21'),
 (12,'App\Models\User',2,'authToken','d17dd854c06246973c9ac66885cc0d92199deb8df6870b01b0ed81b24edeba76','["*"]',NULL,NULL,'2024-02-25 22:35:42','2024-02-25 22:35:42'),
 (13,'App\Models\User',2,'authToken','de2263c64ffe238f818bebe58e1efd13783731f6a75cd9651e3fda809ed420da','["*"]',NULL,NULL,'2024-02-25 22:35:59','2024-02-25 22:35:59'),
 (14,'App\Models\User',2,'authToken','eb99fe08a3279cd01577141f26c47bcae15538d0a2330793bd0895262987d85a','["*"]',NULL,NULL,'2024-02-25 22:36:45','2024-02-25 22:36:45'),
 (15,'App\Models\User',2,'authToken','30573d88089b2cec5f3a0175f4ef7181bf52023d184f2050f11fc6dad95d4f5a','["*"]',NULL,NULL,'2024-02-25 22:36:59','2024-02-25 22:36:59'),
 (16,'App\Models\User',3,'authToken','caeffa9cc9aa3f19dd7467dd9767aefad0730205794e9aef21ab5fc2e76b11b5','["*"]',NULL,NULL,'2024-02-25 23:00:15','2024-02-25 23:00:15'),
 (17,'App\Models\User',2,'authToken','e54f8c40757dcb727823116cbf84d11477d56bd9c478516a9f4a7e0fe1d28df3','["*"]',NULL,NULL,'2024-02-25 23:22:43','2024-02-25 23:22:43'),
 (18,'App\Models\User',2,'authToken','cf8e8821d16b3728974f126fbf4d78372aa7d18e2c0fdd79f2e1ce2437a3fc01','["*"]','2024-02-26 13:37:25',NULL,'2024-02-25 23:23:33','2024-02-26 13:37:25'),
 (19,'App\Models\User',2,'authToken','45208342dfaf5ca0fb0e17e42ddf2e304be31d1ef32c3591b21071c2e3a9c42c','["*"]','2024-02-26 20:23:30',NULL,'2024-02-26 14:26:36','2024-02-26 20:23:30'),
 (20,'App\Models\User',2,'authToken','96cdd5efa14337d9367c9caf20fa3bfb5ab44165d8f16fa54733fdf329fa8712','["*"]',NULL,NULL,'2024-02-26 22:42:53','2024-02-26 22:42:53'),
 (21,'App\Models\User',10,'authToken','6fb6d553d7d33849a1b005a404089f1adfe6e9e20f3340f220c4c394b85d07d7','["*"]','2024-02-26 22:48:40',NULL,'2024-02-26 22:46:55','2024-02-26 22:48:40'),
 (25,'App\Models\User',2,'authToken','f838857d4b6306c5c725778aa14d3baa925b85ebca1806775bf98e61b098678f','["*"]','2024-02-26 23:55:01',NULL,'2024-02-26 23:53:30','2024-02-26 23:55:01'),
 (26,'App\Models\User',11,'authToken','f8538f7809ba1d86c7539a981ff80ad5d6bb0b757fd55033a9aea5729a541721','["*"]',NULL,NULL,'2024-02-26 23:55:18','2024-02-26 23:55:18'),
 (27,'App\Models\User',12,'authToken','5e21f0c84982ccb456c118d305e8ae603f7ec42da351a0646d9361e713be103d','["*"]',NULL,NULL,'2024-02-26 23:56:33','2024-02-26 23:56:33'),
 (28,'App\Models\User',13,'authToken','bfb6309692425be7d5232480a000753d3c6cad2a044a1fa7b9e955e9cfaeb83e','["*"]',NULL,NULL,'2024-02-26 23:57:04','2024-02-26 23:57:04'),
 (29,'App\Models\User',14,'authToken','0c43407883f4584341f6ed6b57dcedd559c5d3f97a5ea024245b0e8dbdfe186d','["*"]',NULL,NULL,'2024-02-26 23:57:24','2024-02-26 23:57:24');
INSERT INTO "tags" ("id","name","created_at","updated_at") VALUES (14,'khhk','2024-02-26 16:58:48','2024-02-26 16:58:48'),
 (16,'rere','2024-02-26 19:27:31','2024-02-26 19:27:31'),
 (17,'Tag 1','2024-02-26 19:32:03','2024-02-26 19:32:03'),
 (19,'Ta 3','2024-02-26 19:32:03','2024-02-26 19:32:03'),
 (20,'Tag 10','2024-02-26 22:59:03','2024-02-26 22:59:03'),
 (21,'Tag 20','2024-02-26 22:59:03','2024-02-26 22:59:03'),
 (22,'Tag 21','2024-02-26 22:59:13','2024-02-26 22:59:13');
INSERT INTO "posts" ("id","user_id","title","body","cover_image","pinned","created_at","updated_at","deleted_at") VALUES (1,5,'First Post','This is 1st post body.','posts/2ctodwuLOpFWUjf8mCX7DMfDGH60JwjhNdfbLlEl.jpg',1,'2024-02-26 19:49:12','2024-02-26 19:49:12',NULL),
 (4,10,'3rd Post','This is 3rd post body.','posts/0hqYZDSrKHfGUo1LoSqPsQ4OZQcdeB5u5dPk8hjh.jpg',0,'2024-02-26 23:05:47','2024-02-26 23:05:47',NULL);
INSERT INTO "post_tags" ("id","post_id","tag_id","created_at","updated_at") VALUES (2,1,19,'2024-02-26 19:51:30','2024-02-26 19:51:30'),
 (3,NULL,14,'2024-02-26 19:58:27','2024-02-26 19:58:27'),
 (4,NULL,14,'2024-02-26 20:15:36','2024-02-26 20:15:36'),
 (5,NULL,16,'2024-02-26 20:15:36','2024-02-26 20:15:36'),
 (6,4,14,'2024-02-26 23:05:47','2024-02-26 23:05:47'),
 (7,4,16,'2024-02-26 23:05:47','2024-02-26 23:05:47'),
 (9,NULL,19,'2024-02-26 23:07:13','2024-02-26 23:07:13');
CREATE UNIQUE INDEX IF NOT EXISTS "users_phone_unique" ON "users" (
	"phone"
);
CREATE UNIQUE INDEX IF NOT EXISTS "failed_jobs_uuid_unique" ON "failed_jobs" (
	"uuid"
);
CREATE INDEX IF NOT EXISTS "personal_access_tokens_tokenable_type_tokenable_id_index" ON "personal_access_tokens" (
	"tokenable_type",
	"tokenable_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "personal_access_tokens_token_unique" ON "personal_access_tokens" (
	"token"
);
CREATE UNIQUE INDEX IF NOT EXISTS "tags_name_unique" ON "tags" (
	"name"
);
COMMIT;
