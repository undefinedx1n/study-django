/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : django_db

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 20/05/2025 01:40:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissions_group_id_b120cbf9`(`group_id`) USING BTREE,
  INDEX `auth_group_permissions_permission_id_84c5c92e`(`permission_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  INDEX `auth_permission_content_type_id_2f476e4b`(`content_type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add model log', 7, 'add_modellog');
INSERT INTO `auth_permission` VALUES (26, 'Can change model log', 7, 'change_modellog');
INSERT INTO `auth_permission` VALUES (27, 'Can delete model log', 7, 'delete_modellog');
INSERT INTO `auth_permission` VALUES (28, 'Can view model log', 7, 'view_modellog');
INSERT INTO `auth_permission` VALUES (29, 'Can add cluster result', 8, 'add_clusterresult');
INSERT INTO `auth_permission` VALUES (30, 'Can change cluster result', 8, 'change_clusterresult');
INSERT INTO `auth_permission` VALUES (31, 'Can delete cluster result', 8, 'delete_clusterresult');
INSERT INTO `auth_permission` VALUES (32, 'Can view cluster result', 8, 'view_clusterresult');
INSERT INTO `auth_permission` VALUES (33, 'Can add student record', 9, 'add_studentrecord');
INSERT INTO `auth_permission` VALUES (34, 'Can change student record', 9, 'change_studentrecord');
INSERT INTO `auth_permission` VALUES (35, 'Can delete student record', 9, 'delete_studentrecord');
INSERT INTO `auth_permission` VALUES (36, 'Can view student record', 9, 'view_studentrecord');
INSERT INTO `auth_permission` VALUES (37, 'Can add 用户资料', 10, 'add_userprofile');
INSERT INTO `auth_permission` VALUES (38, 'Can change 用户资料', 10, 'change_userprofile');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 用户资料', 10, 'delete_userprofile');
INSERT INTO `auth_permission` VALUES (40, 'Can view 用户资料', 10, 'view_userprofile');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 613 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (438, 'pbkdf2_sha256$260000$y1nijOfYFZ55oB9tXOxgW6$QYPu2h14r0Cf+iL8Pf0cvgdtOiZPvhzjN+tLuc8hwVs=', NULL, 0, 'student00035', '', '', 'student00035@example.edu.cn', 0, 1, '2025-05-18 07:00:17.575138');
INSERT INTO `auth_user` VALUES (439, 'pbkdf2_sha256$260000$VzQOYRy1z2PFUAU7bPQoCR$nuGspSyHu5/Xb/b0KJV0tvEuU/YySmvq+HFIAt4HSNg=', NULL, 0, 'student00036', '', '', 'student00036@example.edu.cn', 0, 1, '2025-05-18 07:00:17.682788');
INSERT INTO `auth_user` VALUES (440, 'pbkdf2_sha256$260000$xFvDtC3zefJdXWvRdcSxh1$qlxI30NniNrK3rW4wA6tjZWijJvHsor0Mbx5HH41NMk=', NULL, 0, 'student00037', '', '', 'student00037@example.edu.cn', 0, 1, '2025-05-18 07:00:17.791302');
INSERT INTO `auth_user` VALUES (441, 'pbkdf2_sha256$260000$TyeotwRrJiWFAHuTOKC15L$kUfzuEkrfiYjRn+Nb5khINTqIxYTYfnfHD+MMHbD+OY=', NULL, 0, 'student00038', '', '', 'student00038@example.edu.cn', 0, 1, '2025-05-18 07:00:17.900301');
INSERT INTO `auth_user` VALUES (442, 'pbkdf2_sha256$260000$9muFmjlAAde8AUpzLG0Hm1$1FbSGk+AOJ+B7BiZ+7NscfnxwviHECqCt+Bgxdbdh+o=', NULL, 0, 'student00039', '', '', 'student00039@example.edu.cn', 0, 1, '2025-05-18 07:00:18.013301');
INSERT INTO `auth_user` VALUES (443, 'pbkdf2_sha256$260000$xNV5TftFDXS2BO6DWMDOEX$OrBmXTJVd9zG0g1pmD3qjuoUHFrD6zrys3Pu/hytaj0=', NULL, 0, 'student00040', '', '', 'student00040@example.edu.cn', 0, 1, '2025-05-18 07:00:18.160847');
INSERT INTO `auth_user` VALUES (444, 'pbkdf2_sha256$260000$7dHDx8MnRFZnOuw43WO6rd$zRNWjCH6ytL5vx7Vi+sPfNZodJzOKEM12dKpteOAuzg=', NULL, 0, 'student00041', '', '', 'student00041@example.edu.cn', 0, 1, '2025-05-18 07:00:18.269846');
INSERT INTO `auth_user` VALUES (517, 'pbkdf2_sha256$260000$HUOzkU3TbJMPy03HgCU3Vm$0aCnwvDUkyNQ7wAHU8i2bHqw66nTqvalteSOPxLkNHg=', NULL, 0, 'student00114', '', '', 'student00114@example.edu.cn', 0, 1, '2025-05-18 07:00:26.221356');
INSERT INTO `auth_user` VALUES (516, 'pbkdf2_sha256$260000$uyReE0hbC0cq9D8AuKx9He$1gIrIsNL6S86gbW0lS2c20r6xhMCwKQHeXqQn2B7Moo=', NULL, 0, 'student00113', '', '', 'student00113@example.edu.cn', 0, 1, '2025-05-18 07:00:26.108355');
INSERT INTO `auth_user` VALUES (515, 'pbkdf2_sha256$260000$Z16BIPLrhhMetrZ7gbcFFK$IL1h/Lo4PUF6amrYjwXGDBCo52wFOg5IADn+kCXiqHc=', NULL, 0, 'student00112', '', '', 'student00112@example.edu.cn', 0, 1, '2025-05-18 07:00:26.002355');
INSERT INTO `auth_user` VALUES (514, 'pbkdf2_sha256$260000$pgudyVNDEClNG5VMcx4xg2$kSxbWkZlwwBPby9FjEqYjnpvBQBFFaIO8NYoQHZLaLE=', NULL, 0, 'student00111', '', '', 'student00111@example.edu.cn', 0, 1, '2025-05-18 07:00:25.885356');
INSERT INTO `auth_user` VALUES (513, 'pbkdf2_sha256$260000$Vt3s6m3qRCJNnAI89GEUCw$19Y+ra9TH2egQa6sZ4bj3nh1Ft/K4VXnY1+YH+cO7PY=', NULL, 0, 'student00110', '', '', 'student00110@example.edu.cn', 0, 1, '2025-05-18 07:00:25.778841');
INSERT INTO `auth_user` VALUES (512, 'pbkdf2_sha256$260000$z66bAxKOfwzQSSlOHX0xiV$6TyJqwLFhg00JYOIMdd1k+v1a//dzwfotU8wDqeNgCw=', NULL, 0, 'student00109', '', '', 'student00109@example.edu.cn', 0, 1, '2025-05-18 07:00:25.673291');
INSERT INTO `auth_user` VALUES (511, 'pbkdf2_sha256$260000$YgE2znx0986L9OysP5DS5k$njKhAiQYMK/o7ieaH8QK6HEhBSDPZjxxA0c7pZ7Nqbs=', NULL, 0, 'student00108', '', '', 'student00108@example.edu.cn', 0, 1, '2025-05-18 07:00:25.567291');
INSERT INTO `auth_user` VALUES (510, 'pbkdf2_sha256$260000$oBeFiEdJ2ryV3JTSRQfMwn$TjUWs8fPahT1zRUTbmnJsBd7EfJL9rmYvzfXsTSyCjo=', NULL, 0, 'student00107', '', '', 'student00107@example.edu.cn', 0, 1, '2025-05-18 07:00:25.459291');
INSERT INTO `auth_user` VALUES (509, 'pbkdf2_sha256$260000$IHd0wNulxUfypvuPsSonWu$7iExhrYlFZAZ3UxQCQ4ldo4tAfX7HnxwpeWWh+lWb/E=', NULL, 0, 'student00106', '', '', 'student00106@example.edu.cn', 0, 1, '2025-05-18 07:00:25.353205');
INSERT INTO `auth_user` VALUES (508, 'pbkdf2_sha256$260000$BFAHTemISEupTgAATkLQka$6hjpH1fsrYsrEktQywz8zKfZ6HKu9xfu093KSeLi7RA=', NULL, 0, 'student00105', '', '', 'student00105@example.edu.cn', 0, 1, '2025-05-18 07:00:25.246426');
INSERT INTO `auth_user` VALUES (507, 'pbkdf2_sha256$260000$so3DpXEkTR6dAIlJm7dx97$x4n4rDz62g8YyetTcXtSmcMuBXt6zCbLcv1QJ8X/Yfc=', NULL, 0, 'student00104', '', '', 'student00104@example.edu.cn', 0, 1, '2025-05-18 07:00:25.138426');
INSERT INTO `auth_user` VALUES (506, 'pbkdf2_sha256$260000$302dsZ8FqET8PO7dqUFVo4$2TRsuNuthIJNQmBz4z23P9gZpewEfIfAj3of+M+H8to=', NULL, 0, 'student00103', '', '', 'student00103@example.edu.cn', 0, 1, '2025-05-18 07:00:25.031427');
INSERT INTO `auth_user` VALUES (505, 'pbkdf2_sha256$260000$F2wLe3NCM4d0kNmUz1h8WC$baciGpwRrox47eUFfeuS1ZhEwVjAbnM1ncTwXH/rjJE=', NULL, 0, 'student00102', '', '', 'student00102@example.edu.cn', 0, 1, '2025-05-18 07:00:24.921427');
INSERT INTO `auth_user` VALUES (504, 'pbkdf2_sha256$260000$8612bZtI6mi7WeAnlBnYii$3JYIXsRuT7HNBPz93JUiLtBh71JikcqFjRxPGoXwNoA=', NULL, 0, 'student00101', '', '', 'student00101@example.edu.cn', 0, 1, '2025-05-18 07:00:24.807344');
INSERT INTO `auth_user` VALUES (503, 'pbkdf2_sha256$260000$eym0KiBpyuPN8D6LQw9DNo$KZcTJhSkUPtaWzbkp4VMQWPAdZnSZ9uasZ2y00TaCf4=', NULL, 0, 'student00100', '', '', 'student00100@example.edu.cn', 0, 1, '2025-05-18 07:00:24.699345');
INSERT INTO `auth_user` VALUES (502, 'pbkdf2_sha256$260000$XvkzVfS1LMYZvDBgfxAvBu$QcYOjb/BVuAsOyc2eCoN0V2scU+X+k/uHsg1byHbsrc=', NULL, 0, 'student00099', '', '', 'student00099@example.edu.cn', 0, 1, '2025-05-18 07:00:24.591345');
INSERT INTO `auth_user` VALUES (501, 'pbkdf2_sha256$260000$oyz5AAbIZiHODCm2cHLumo$ag23uM70ofKJvSmB0hVcaY8XSlBY6SwS0+2rCyIpP2A=', NULL, 0, 'student00098', '', '', 'student00098@example.edu.cn', 0, 1, '2025-05-18 07:00:24.470832');
INSERT INTO `auth_user` VALUES (500, 'pbkdf2_sha256$260000$GKtAHBjW6UxFJaOzKPYDZ4$5Ea9Xr2liSpq1gHcsTpH3XNTSkZ8okJWGTV6UKAf43k=', NULL, 0, 'student00097', '', '', 'student00097@example.edu.cn', 0, 1, '2025-05-18 07:00:24.338726');
INSERT INTO `auth_user` VALUES (499, 'pbkdf2_sha256$260000$wtBdcZTM8iudojoHNGZVIL$X7eUKMSNpKTttJm2eVtwmT3TvN1OPpRTblEYZX9asN4=', NULL, 0, 'student00096', '', '', 'student00096@example.edu.cn', 0, 1, '2025-05-18 07:00:24.231877');
INSERT INTO `auth_user` VALUES (498, 'pbkdf2_sha256$260000$OrOqvCKpZnjW9D96wlLaZl$PIubyQhOmuarWeLh2duTK5k2IccB7AiFIjKzzedu+PQ=', NULL, 0, 'student00095', '', '', 'student00095@example.edu.cn', 0, 1, '2025-05-18 07:00:24.126453');
INSERT INTO `auth_user` VALUES (497, 'pbkdf2_sha256$260000$pN5pJcGrLSvM9WAKUbnIfM$SEO17ReNLNZNlePVtC39rtlaqW/rOpcPD2Z6ZLRQZLI=', NULL, 0, 'student00094', '', '', 'student00094@example.edu.cn', 0, 1, '2025-05-18 07:00:24.021453');
INSERT INTO `auth_user` VALUES (496, 'pbkdf2_sha256$260000$bhrTnubiMp44Qbrp0fuu6k$gm1WNjECVXm90x/PHQ9xRFMYKeRORpRLw/mCAe+ipJs=', NULL, 0, 'student00093', '', '', 'student00093@example.edu.cn', 0, 1, '2025-05-18 07:00:23.913340');
INSERT INTO `auth_user` VALUES (495, 'pbkdf2_sha256$260000$MaPHid4gDpqqZdE2pqtFUT$LUVIaeXTu4VzbHPQ4yuPHnMtfa5da4AxX7gGzacKSVQ=', NULL, 0, 'student00092', '', '', 'student00092@example.edu.cn', 0, 1, '2025-05-18 07:00:23.805339');
INSERT INTO `auth_user` VALUES (494, 'pbkdf2_sha256$260000$Ra5N1vmFQKPthVpIAukhZ8$9o+ASSeREWDuvl5ELEOfRivlpKI4AL2BOliteWiKV3s=', NULL, 0, 'student00091', '', '', 'student00091@example.edu.cn', 0, 1, '2025-05-18 07:00:23.690340');
INSERT INTO `auth_user` VALUES (493, 'pbkdf2_sha256$260000$97d0dldlWexcX9lkOOIgk8$1nZmwFY2DbEml0pMT7ZPc6cSXuOLLnzY2cT6cPdp8DY=', NULL, 0, 'student00090', '', '', 'student00090@example.edu.cn', 0, 1, '2025-05-18 07:00:23.583340');
INSERT INTO `auth_user` VALUES (492, 'pbkdf2_sha256$260000$9Z30GJD78jgxfhPDxpW9BQ$WrvRNk9EXp6np6eSvOddSQCV1s9tI+xxkhPZ1+6ra2w=', NULL, 0, 'student00089', '', '', 'student00089@example.edu.cn', 0, 1, '2025-05-18 07:00:23.475341');
INSERT INTO `auth_user` VALUES (491, 'pbkdf2_sha256$260000$TST5NsYEtDZDHpZxxwMFRd$0Jd2vspNjuKc82xDt3PamVahenw8QXb15dt5fxF2S0Q=', NULL, 0, 'student00088', '', '', 'student00088@example.edu.cn', 0, 1, '2025-05-18 07:00:23.367342');
INSERT INTO `auth_user` VALUES (490, 'pbkdf2_sha256$260000$Mg66bsK0W0XHA24OTHU9rN$rX1fM29ooyqEVkUqb1FiIdldkXVjExO9vlQbGgghRyI=', NULL, 0, 'student00087', '', '', 'student00087@example.edu.cn', 0, 1, '2025-05-18 07:00:23.260342');
INSERT INTO `auth_user` VALUES (489, 'pbkdf2_sha256$260000$oHo57g6Y7UuL6TmOoYQ7Yj$DOmgRwNKKjQYU/3JXHwEK6W9Ju5KxhBM648WZ8OrGPk=', NULL, 0, 'student00086', '', '', 'student00086@example.edu.cn', 0, 1, '2025-05-18 07:00:23.153342');
INSERT INTO `auth_user` VALUES (488, 'pbkdf2_sha256$260000$ptti8C6OYj9JHd8c8r7lBj$WVD+vMZOJoRPYdjnzWQHlSoyKkJ+QS7+0BVwADgqFrg=', NULL, 0, 'student00085', '', '', 'student00085@example.edu.cn', 0, 1, '2025-05-18 07:00:23.048343');
INSERT INTO `auth_user` VALUES (487, 'pbkdf2_sha256$260000$keVmtUX7IIr37KTnggWNvj$eObo8rkkR66yRXTOZPl2xro8Dv5OEX4jYFwaXknB+wI=', NULL, 0, 'student00084', '', '', 'student00084@example.edu.cn', 0, 1, '2025-05-18 07:00:22.935343');
INSERT INTO `auth_user` VALUES (486, 'pbkdf2_sha256$260000$6r7gdmm9ERLFPo4DKpuUqJ$nSCx+0pEHk73Of6MlxPyiav2k2p/LutaeznWXttU6Ic=', NULL, 0, 'student00083', '', '', 'student00083@example.edu.cn', 0, 1, '2025-05-18 07:00:22.824449');
INSERT INTO `auth_user` VALUES (485, 'pbkdf2_sha256$260000$JiQ9TCqphRRx63tDnRKxwA$T8CLl6hYyMInp3k/T454F8S0NkurNp5RSKpC7tTe220=', NULL, 0, 'student00082', '', '', 'student00082@example.edu.cn', 0, 1, '2025-05-18 07:00:22.716265');
INSERT INTO `auth_user` VALUES (484, 'pbkdf2_sha256$260000$RX3AlBOsiHMQa61d9DWVfB$22y2uX9boWaJJftLIffKFZm8/HpW911PilB3ckOXBLg=', NULL, 0, 'student00081', '', '', 'student00081@example.edu.cn', 0, 1, '2025-05-18 07:00:22.609265');
INSERT INTO `auth_user` VALUES (483, 'pbkdf2_sha256$260000$n4HOObY9fXvnCiQ1rfTkhw$KI6e/IiMQFo3BI/ZP232C9l+6dG3Wy0ijQipTmvmo3k=', NULL, 0, 'student00080', '', '', 'student00080@example.edu.cn', 0, 1, '2025-05-18 07:00:22.496512');
INSERT INTO `auth_user` VALUES (482, 'pbkdf2_sha256$260000$4xwmk7W5yMujFFX78S8kOy$C1+XeCsIxiG+KOidvOlbS4pUS3FLU5X89lSYiWaSCSA=', NULL, 0, 'student00079', '', '', 'student00079@example.edu.cn', 0, 1, '2025-05-18 07:00:22.389512');
INSERT INTO `auth_user` VALUES (481, 'pbkdf2_sha256$260000$3iE0yjwyUOr2p80OaZvVF4$pdMewZCZSVRCvdBZ5PDl9CoSOxAyyF6djYHv7JH21HI=', NULL, 0, 'student00078', '', '', 'student00078@example.edu.cn', 0, 1, '2025-05-18 07:00:22.282965');
INSERT INTO `auth_user` VALUES (480, 'pbkdf2_sha256$260000$doMAMT9qQ0DWvnU409VRcU$Qas6w6exw11Y9Xab6kPyrVxrY2AhQvYuVO8a1+1VYLk=', NULL, 0, 'student00077', '', '', 'student00077@example.edu.cn', 0, 1, '2025-05-18 07:00:22.176400');
INSERT INTO `auth_user` VALUES (479, 'pbkdf2_sha256$260000$nJmU8vWREf7biMny7Ekz4C$OQJkV2djqWovSZlOTMmh4LG1JuStEGSrLpWYWp62+sg=', NULL, 0, 'student00076', '', '', 'student00076@example.edu.cn', 0, 1, '2025-05-18 07:00:22.069315');
INSERT INTO `auth_user` VALUES (478, 'pbkdf2_sha256$260000$c8TuQQPusKzQWM0JoUQqD0$HZ0DrmvV2mj5WaZ4+2Mx9LIKtzOXGzfEXVPGNH5mCLQ=', '2025-05-19 09:56:49.360442', 0, 'student00075', '', '', 'student00075@example.edu.cn', 0, 1, '2025-05-18 07:00:21.961224');
INSERT INTO `auth_user` VALUES (477, 'pbkdf2_sha256$260000$ed3uktE3cVX4wMLu0XDxUE$KhAVurDAsu8nXCvM5lASXcSzMevJ7XfFu5+uTQZ2spo=', NULL, 0, 'student00074', '', '', 'student00074@example.edu.cn', 0, 1, '2025-05-18 07:00:21.850682');
INSERT INTO `auth_user` VALUES (476, 'pbkdf2_sha256$260000$SdFZLcUXE9tHvnQ1lU68Iq$1jrv8+LbD+WqugK7UQKad1M1GrMbP/m4eSUg9ro3C2c=', NULL, 0, 'student00073', '', '', 'student00073@example.edu.cn', 0, 1, '2025-05-18 07:00:21.744076');
INSERT INTO `auth_user` VALUES (475, 'pbkdf2_sha256$260000$qiPgyvi11m8Ss0ycYongPn$weqb5bQ5t6jhLi7zJNJjs2LMdUqfkgGSXjMv4BiMnHA=', NULL, 0, 'student00072', '', '', 'student00072@example.edu.cn', 0, 1, '2025-05-18 07:00:21.634076');
INSERT INTO `auth_user` VALUES (474, 'pbkdf2_sha256$260000$fVKd2gSwSMhNipICgqIjrq$iNDtQDehR0YpI7wzc5DDPeY8wSI80TC7IPrLuLVmsBU=', NULL, 0, 'student00071', '', '', 'student00071@example.edu.cn', 0, 1, '2025-05-18 07:00:21.516077');
INSERT INTO `auth_user` VALUES (473, 'pbkdf2_sha256$260000$skh71w4mI0hRttMQ4laHvH$kzXJQtZqOjS6cdP9hAM5o7bnhCEs6+puHJ267vIt3TA=', NULL, 0, 'student00070', '', '', 'student00070@example.edu.cn', 0, 1, '2025-05-18 07:00:21.408078');
INSERT INTO `auth_user` VALUES (472, 'pbkdf2_sha256$260000$dhFK5vUW5qG2BEO3KOBr3F$teMRQV2NW9oLsXvf0n1eJvdFsA7DJPOFlJVx2KmYq7U=', NULL, 0, 'student00069', '', '', 'student00069@example.edu.cn', 0, 1, '2025-05-18 07:00:21.294077');
INSERT INTO `auth_user` VALUES (471, 'pbkdf2_sha256$260000$yjgy7hVkaOzslvOZm8Oh4C$5FJ2zI3ngQhWcjpFm4ItSL6hW+M15cuwHoJL54Jvf+o=', NULL, 0, 'student00068', '', '', 'student00068@example.edu.cn', 0, 1, '2025-05-18 07:00:21.189078');
INSERT INTO `auth_user` VALUES (470, 'pbkdf2_sha256$260000$SguTlFCGUMeOKPcTcEzeaC$vgWwZXUmefK0YJNbi4GJbB00edhQOBam7g5kc4fpJPg=', NULL, 0, 'student00067', '', '', 'student00067@example.edu.cn', 0, 1, '2025-05-18 07:00:21.082079');
INSERT INTO `auth_user` VALUES (469, 'pbkdf2_sha256$260000$0J5dnyvMVVHEEsH5Pa6G7J$p5nTqYi3KagRVAP4I+st4qNeZ9LSAs6KgCuYePMPl0o=', NULL, 0, 'student00066', '', '', 'student00066@example.edu.cn', 0, 1, '2025-05-18 07:00:20.974079');
INSERT INTO `auth_user` VALUES (468, 'pbkdf2_sha256$260000$mem7jajvSmaleLkx9Oj8vb$3KtvXR5y127fl0XJs90BBmKJopjtBTLfso/7MdzJ7lY=', NULL, 0, 'student00065', '', '', 'student00065@example.edu.cn', 0, 1, '2025-05-18 07:00:20.868080');
INSERT INTO `auth_user` VALUES (467, 'pbkdf2_sha256$260000$wmuIbrL9hO1Bezq3biZGHn$6TSH/dERk093mygFNxzy7X1dher6ka0D392ezK4VzG8=', NULL, 0, 'student00064', '', '', 'student00064@example.edu.cn', 0, 1, '2025-05-18 07:00:20.760345');
INSERT INTO `auth_user` VALUES (466, 'pbkdf2_sha256$260000$nJ3sJdbAX7hwQynsXzCHuU$9JVoch1YqSZAiFo98qCoaXTz/Oi71SW73B9AR6TvdIs=', NULL, 0, 'student00063', '', '', 'student00063@example.edu.cn', 0, 1, '2025-05-18 07:00:20.652345');
INSERT INTO `auth_user` VALUES (465, 'pbkdf2_sha256$260000$IOuwl8z1dLEfd1IpLXTTaD$aOImulzpk7+EoLvny/OVdEOoKKrGnLRtxxH/WW59Dag=', NULL, 0, 'student00062', '', '', 'student00062@example.edu.cn', 0, 1, '2025-05-18 07:00:20.541345');
INSERT INTO `auth_user` VALUES (464, 'pbkdf2_sha256$260000$h9jjwITGI5BXbcacTgC7Uf$cHa2UcQY0sDxROs6gEBUd6mUSzgDa3gAn84gMcQtiUc=', NULL, 0, 'student00061', '', '', 'student00061@example.edu.cn', 0, 1, '2025-05-18 07:00:20.434178');
INSERT INTO `auth_user` VALUES (463, 'pbkdf2_sha256$260000$wrhBYD0ZxozwoPmROEwpfM$0/WpoBjMYk9dO+cV4b3K0a9gyIhdfZmLpn/Mmr/ZkM0=', NULL, 0, 'student00060', '', '', 'student00060@example.edu.cn', 0, 1, '2025-05-18 07:00:20.326109');
INSERT INTO `auth_user` VALUES (462, 'pbkdf2_sha256$260000$KFqDzYWDIycEure90wFg9z$5hjNiq76dVxSNJgtQdc7dtJr0bZFXEhAady48mPITdA=', NULL, 0, 'student00059', '', '', 'student00059@example.edu.cn', 0, 1, '2025-05-18 07:00:20.203110');
INSERT INTO `auth_user` VALUES (461, 'pbkdf2_sha256$260000$XjoTma7hXkYIws4wbElCbI$MGk/Ry/di8om2nhyLzhRAFBZk55ATkLdaVjaTUf4ZSU=', NULL, 0, 'student00058', '', '', 'student00058@example.edu.cn', 0, 1, '2025-05-18 07:00:20.095111');
INSERT INTO `auth_user` VALUES (460, 'pbkdf2_sha256$260000$oWGQOkHaXEfKiqH7tNysgA$KJaimdx2Ap9Z1itiQ8GAH5CeaTM/6p3eG6ZRnezZMSE=', NULL, 0, 'student00057', '', '', 'student00057@example.edu.cn', 0, 1, '2025-05-18 07:00:19.980494');
INSERT INTO `auth_user` VALUES (459, 'pbkdf2_sha256$260000$0HqWIGKY3a8msUz7b2BmH1$DJuqLO7CAdvc/r1e/o/JFeXnCd79kz9oXq5QK7vX4Tc=', NULL, 0, 'student00056', '', '', 'student00056@example.edu.cn', 0, 1, '2025-05-18 07:00:19.872494');
INSERT INTO `auth_user` VALUES (458, 'pbkdf2_sha256$260000$KIBtdZ5tbv27zj12viv0sQ$QQgnikwoO4O/XXuRBzac1c4trI98BJRfTQuCaSXWkpM=', NULL, 0, 'student00055', '', '', 'student00055@example.edu.cn', 0, 1, '2025-05-18 07:00:19.766495');
INSERT INTO `auth_user` VALUES (456, 'pbkdf2_sha256$260000$tFFl6RwNZl32CGnCKqj2x7$6rVjuRACHYNSCgTSsmZas+rOY4MMTb5nKYh8tutZzVY=', NULL, 0, 'student00053', '', '', 'student00053@example.edu.cn', 0, 1, '2025-05-18 07:00:19.555100');
INSERT INTO `auth_user` VALUES (455, 'pbkdf2_sha256$260000$N32gG6fzveYCNEVeUDJoCt$iGFLlM9mSmXiM9NH60ZnpEkNeOyjTO9w4cDr/d8J698=', NULL, 0, 'student00052', '', '', 'student00052@example.edu.cn', 0, 1, '2025-05-18 07:00:19.450100');
INSERT INTO `auth_user` VALUES (454, 'pbkdf2_sha256$260000$ZBmMDAfpFYPNEs5rcw5YJU$RDgxR71gjY1tSglSVxiRjdwDvrUIaLUFCC/sIR/zOnA=', NULL, 0, 'student00051', '', '', 'student00051@example.edu.cn', 0, 1, '2025-05-18 07:00:19.344571');
INSERT INTO `auth_user` VALUES (453, 'pbkdf2_sha256$260000$kM3pETRXNwGgpxu7zteUkN$ofHQ/YbnnUJi1a9ge6HFTgLmDKq7q5BP+y2P6cBpW48=', NULL, 0, 'student00050', '', '', 'student00050@example.edu.cn', 0, 1, '2025-05-18 07:00:19.239030');
INSERT INTO `auth_user` VALUES (452, 'pbkdf2_sha256$260000$tznuRohZb6P1kQ6OuGVegw$fxEbNDdYwbaZsdq/H2kwYOE3VJ9awQDTVYHTruIuxCE=', NULL, 0, 'student00049', '', '', 'student00049@example.edu.cn', 0, 1, '2025-05-18 07:00:19.133562');
INSERT INTO `auth_user` VALUES (451, 'pbkdf2_sha256$260000$149vxN0cbGPQchefsleJpR$h5+mwRwP7YI8XLncRMS1dz6P6QjLku3LGIu8kPNwysg=', NULL, 0, 'student00048', '', '', 'student00048@example.edu.cn', 0, 1, '2025-05-18 07:00:19.025854');
INSERT INTO `auth_user` VALUES (450, 'pbkdf2_sha256$260000$S9xpUca7MyxJ2J1NbnZP50$VoKDLmmVJhXemIV1pF6ft2oVGRWx1BN9EDu7Vq+I8gE=', NULL, 0, 'student00047', '', '', 'student00047@example.edu.cn', 0, 1, '2025-05-18 07:00:18.917592');
INSERT INTO `auth_user` VALUES (449, 'pbkdf2_sha256$260000$NH0sXaGxSOSoQEuCeslM53$taKkjv8Kkn2OVQpw3vQ6h9LTK1OwFjxtexnEgTrS8tI=', NULL, 0, 'student00046', '', '', 'student00046@example.edu.cn', 0, 1, '2025-05-18 07:00:18.812593');
INSERT INTO `auth_user` VALUES (448, 'pbkdf2_sha256$260000$5Qod0ADo0BdvCvtP4IzqFo$Ztw79ybuHsgtQfBcX7ExRaQ0wMQdzSyuNojCrr0EUmc=', NULL, 0, 'student00045', '', '', 'student00045@example.edu.cn', 0, 1, '2025-05-18 07:00:18.706592');
INSERT INTO `auth_user` VALUES (447, 'pbkdf2_sha256$260000$cn2ddVhoGnCMSrAAbh8AqJ$/ptFukDFu6xAR4BzmIq9WlDvDaLsO6qvK4GrjjNOpkE=', NULL, 0, 'student00044', '', '', 'student00044@example.edu.cn', 0, 1, '2025-05-18 07:00:18.601169');
INSERT INTO `auth_user` VALUES (446, 'pbkdf2_sha256$260000$eV47L7VBxq3gxWHXBjqDSd$c6qPb8G/DKKU5OaPmpICr/uKpEuuJNlrGiiQRCkQhok=', NULL, 0, 'student00043', '', '', 'student00043@example.edu.cn', 0, 1, '2025-05-18 07:00:18.495456');
INSERT INTO `auth_user` VALUES (445, 'pbkdf2_sha256$260000$SNk0tjFxFYyZhMH6yPO3sB$+gF8ArTuTkAXcpbjKdssGdH4+tN/ygOCXKWWioXoAB8=', NULL, 0, 'student00042', '', '', 'student00042@example.edu.cn', 0, 1, '2025-05-18 07:00:18.388456');
INSERT INTO `auth_user` VALUES (404, 'pbkdf2_sha256$260000$Edb2fHmD8CGvFcrKgK1AYN$t/FnfcBTCNCHTRoWN34j6SZNOvPrj4XyEK3dtacM8U4=', '2025-05-18 09:29:41.820546', 0, 'student00001', '', '', 'student00001@example.edu.cn', 0, 1, '2025-05-18 07:00:13.788763');
INSERT INTO `auth_user` VALUES (405, 'pbkdf2_sha256$260000$uX9yoqaPr4PfgZQPn8GhzP$zOdr9RYCLjgUTSPgNgrYxWQeNM9u1DlTQQs0E/mEXjw=', NULL, 0, 'student00002', '', '', 'student00002@example.edu.cn', 0, 1, '2025-05-18 07:00:13.894763');
INSERT INTO `auth_user` VALUES (406, 'pbkdf2_sha256$260000$mcz1RMNW4nDEGVw77r0MN6$wun/U7R1CJjSmlcEactJNBiALfeFBiQsrfBxBH0nycU=', NULL, 0, 'student00003', '', '', 'student00003@example.edu.cn', 0, 1, '2025-05-18 07:00:14.000252');
INSERT INTO `auth_user` VALUES (407, 'pbkdf2_sha256$260000$61SAOFhkETOBj8wBrTQUcf$4frZNWRmem5svMKM3w6qr9cGXV4vxLfkLny5x6vMtxA=', NULL, 0, 'student00004', '', '', 'student00004@example.edu.cn', 0, 1, '2025-05-18 07:00:14.108790');
INSERT INTO `auth_user` VALUES (408, 'pbkdf2_sha256$260000$K4WVb6ZMs3cOkIDFWFBxD3$bM99gBvQPuP6y2gMTdAlssZLzgXvETjIVidsqAxS6DI=', NULL, 0, 'student00005', '', '', 'student00005@example.edu.cn', 0, 1, '2025-05-18 07:00:14.215392');
INSERT INTO `auth_user` VALUES (409, 'pbkdf2_sha256$260000$YRXdNK0Da2qaZq2xxVuAwx$229+FpFPwuxBgYiSq7OrwrYx+isE+zXcwU83Gq58uQQ=', NULL, 0, 'student00006', '', '', 'student00006@example.edu.cn', 0, 1, '2025-05-18 07:00:14.322485');
INSERT INTO `auth_user` VALUES (410, 'pbkdf2_sha256$260000$3OJoeXXVR2KoQN6Uw9hQQY$WSZIbFXI4iG92of3iTQkRmXkHlm/+bW4UdcqurlGRmg=', NULL, 0, 'student00007', '', '', 'student00007@example.edu.cn', 0, 1, '2025-05-18 07:00:14.435484');
INSERT INTO `auth_user` VALUES (411, 'pbkdf2_sha256$260000$2CoBBxhUnd6ISgoxFw7tmx$whP+h3puUYbzuR1RH9ROLdb1YNgYF7THy7G+muq3SsU=', NULL, 0, 'student00008', '', '', 'student00008@example.edu.cn', 0, 1, '2025-05-18 07:00:14.541484');
INSERT INTO `auth_user` VALUES (412, 'pbkdf2_sha256$260000$o4M64QwijjCHePCK5A5IKb$Fv6ZFab+e4cRl/BmG73sLYhgQX9bNcvKojFkPixOljI=', NULL, 0, 'student00009', '', '', 'student00009@example.edu.cn', 0, 1, '2025-05-18 07:00:14.648575');
INSERT INTO `auth_user` VALUES (413, 'pbkdf2_sha256$260000$wAvVFX8ukhcK8hI1pl6YD8$OFqWm5aINF9J8SWrPmZrk32BE+QZqxCA5wxgR6/Q1bU=', NULL, 0, 'student00010', '', '', 'student00010@example.edu.cn', 0, 1, '2025-05-18 07:00:14.754574');
INSERT INTO `auth_user` VALUES (414, 'pbkdf2_sha256$260000$JIgssBlRXMIhuepLZockTy$iLfr35OCZLXJ/oKLH7tb4bpIpr4e7RI+gtirwlV7lp4=', NULL, 0, 'student00011', '', '', 'student00011@example.edu.cn', 0, 1, '2025-05-18 07:00:14.859736');
INSERT INTO `auth_user` VALUES (415, 'pbkdf2_sha256$260000$cuqR6mpspYwqDVvS8Shrfj$rgYcdLZW0B0Yfs08ZF2AC4V+aFumCMxD+Ep6u3hfqX4=', NULL, 0, 'student00012', '', '', 'student00012@example.edu.cn', 0, 1, '2025-05-18 07:00:14.965735');
INSERT INTO `auth_user` VALUES (416, 'pbkdf2_sha256$260000$VSbyu81EsENKnuXUrLV8E1$FsBSEy/uGWtBYtHSYJ37pEwZo1tnvd3SQVXdfB8SY3I=', NULL, 0, 'student00013', '', '', 'student00013@example.edu.cn', 0, 1, '2025-05-18 07:00:15.097732');
INSERT INTO `auth_user` VALUES (417, 'pbkdf2_sha256$260000$vV2YjfFwGPF9vNfM4rYQG3$XAOeWNNUQ3ChM5YoqzToFPdmKkirsHmdd8Ky86CssEQ=', NULL, 0, 'student00014', '', '', 'student00014@example.edu.cn', 0, 1, '2025-05-18 07:00:15.204817');
INSERT INTO `auth_user` VALUES (418, 'pbkdf2_sha256$260000$YrWCBiT1ROvawTbcQpiyrk$rPYlm6NngZP4qxcW7QTryHjR1gtc4630pwYPM7XKmQ8=', NULL, 0, 'student00015', '', '', 'student00015@example.edu.cn', 0, 1, '2025-05-18 07:00:15.310817');
INSERT INTO `auth_user` VALUES (419, 'pbkdf2_sha256$260000$DAWGXduIjISXyNdvc35KAW$JoYGc0fER9jK9mTe6HnFBz2DaGqgQPhd5e4fuviznEM=', NULL, 0, 'student00016', '', '', 'student00016@example.edu.cn', 0, 1, '2025-05-18 07:00:15.417884');
INSERT INTO `auth_user` VALUES (420, 'pbkdf2_sha256$260000$HhFAqROxtFKVeRxEBK1yEB$GGhcCGd3pSD9n0TW/d12HvJwZ+Sea8KYjDNnYPzZmU8=', NULL, 0, 'student00017', '', '', 'student00017@example.edu.cn', 0, 1, '2025-05-18 07:00:15.544089');
INSERT INTO `auth_user` VALUES (421, 'pbkdf2_sha256$260000$xFwTdlbkcIcSSRXM40pEfp$/uctKuY5k8DPpZRjGzn9qRlmpTfUFKVCGNe59Nz0X2c=', '2025-05-19 10:14:55.196995', 0, 'student00018', '', '', 'student00018@example.edu.cn', 0, 1, '2025-05-18 07:00:15.649932');
INSERT INTO `auth_user` VALUES (422, 'pbkdf2_sha256$260000$OqtKoh7vX8pRsVgnnM4FAA$3psI00ABEJNokufTWDhLabwtfonQuIZeU2NAa54yx+o=', NULL, 0, 'student00019', '', '', 'student00019@example.edu.cn', 0, 1, '2025-05-18 07:00:15.755931');
INSERT INTO `auth_user` VALUES (423, 'pbkdf2_sha256$260000$FfvZlCqIf94vBuDagzA5Z2$MkGpvc9zNZ5241DICJH1FMb7wgecycNowUR4nne0Gf4=', '2025-05-19 09:34:03.103713', 0, 'student00020', '', '', 'student00020@example.edu.cn', 0, 1, '2025-05-18 07:00:15.864931');
INSERT INTO `auth_user` VALUES (424, 'pbkdf2_sha256$260000$dRyFc47yzTHifkO929K6q7$eInOJEzVCUrTuzONRnZd7Gz3TilZ5Ac0Gd/ZPlm6rzM=', '2025-05-19 09:34:46.704792', 0, 'student00021', '', '', 'student00021@example.edu.cn', 0, 1, '2025-05-18 07:00:15.973931');
INSERT INTO `auth_user` VALUES (425, 'pbkdf2_sha256$260000$PtUfskxGR21Fg7w15N0Omw$6SuXjPrBRsTR3SOjjBlV6/G1vXI9VSZPpZUE2vl6W6E=', NULL, 0, 'student00022', '', '', 'student00022@example.edu.cn', 0, 1, '2025-05-18 07:00:16.081930');
INSERT INTO `auth_user` VALUES (426, 'pbkdf2_sha256$260000$cGEtDPADlyCd8bLsFAHJkA$dPnWIC5mowDnAWDh6TSAgpdxvwrLVP3oBbco7QFKWnw=', NULL, 0, 'student00023', '', '', 'student00023@example.edu.cn', 0, 1, '2025-05-18 07:00:16.191930');
INSERT INTO `auth_user` VALUES (427, 'pbkdf2_sha256$260000$Wow8eV0dWduaoz0GhyUlFl$k6E4gORy1FUS0vpba7xrGdXro3jTWiiZWl8OmDuELXo=', NULL, 0, 'student00024', '', '', 'student00024@example.edu.cn', 0, 1, '2025-05-18 07:00:16.316202');
INSERT INTO `auth_user` VALUES (428, 'pbkdf2_sha256$260000$NQfyKhoSkAVSuvFBglk1Xh$EnVfAts1uM5fQpzYLiLSi/aK5ISMR6whSPS0ArTUM3Q=', NULL, 0, 'student00025', '', '', 'student00025@example.edu.cn', 0, 1, '2025-05-18 07:00:16.424062');
INSERT INTO `auth_user` VALUES (429, 'pbkdf2_sha256$260000$4DxF3odn6QhTu4fIVtgDRe$VaEbeDFu/4uvtk0+KQDgrIvX1akrRq/Csff5MRbbyWI=', NULL, 0, 'student00026', '', '', 'student00026@example.edu.cn', 0, 1, '2025-05-18 07:00:16.529264');
INSERT INTO `auth_user` VALUES (430, 'pbkdf2_sha256$260000$F1Tt8roU1LmR4qF3LRuxAI$l6svZ4Gv7HQrPe2oeEk/24gU4dYxkaSC4JrDToPNLfU=', NULL, 0, 'student00027', '', '', 'student00027@example.edu.cn', 0, 1, '2025-05-18 07:00:16.635264');
INSERT INTO `auth_user` VALUES (431, 'pbkdf2_sha256$260000$OS3YEtr46QxGpdPqTLNV6G$8dFlaWOBc4m5/8eZsJd1zBGFHu7TrsnfD+H4aVVX1MQ=', NULL, 0, 'student00028', '', '', 'student00028@example.edu.cn', 0, 1, '2025-05-18 07:00:16.779628');
INSERT INTO `auth_user` VALUES (432, 'pbkdf2_sha256$260000$SDuYmk2Ar70ElCg0r0lUm5$GGom4BbM/p59Cdsdg+4c6625RaZGU94UAcrfDTmsVx0=', NULL, 0, 'student00029', '', '', 'student00029@example.edu.cn', 0, 1, '2025-05-18 07:00:16.891141');
INSERT INTO `auth_user` VALUES (433, 'pbkdf2_sha256$260000$IlV9fgpxNqp92AaSwy6f9a$pnblvxiYgpcVYmPauMzdqh1/FHcSxAyTHvSM66owH7U=', NULL, 0, 'student00030', '', '', 'student00030@example.edu.cn', 0, 1, '2025-05-18 07:00:16.999141');
INSERT INTO `auth_user` VALUES (434, 'pbkdf2_sha256$260000$EedD63eu3h9q77C08ibJVv$no+N90HP+K75TkmY8hNUmtiBm66PJvfn2+fVi3PmQZs=', NULL, 0, 'student00031', '', '', 'student00031@example.edu.cn', 0, 1, '2025-05-18 07:00:17.112141');
INSERT INTO `auth_user` VALUES (435, 'pbkdf2_sha256$260000$UusHkr6a5iFEWPfe4adpUX$A0db+lgi4hLFUwE0HvzGqNym5shvpHBdIonE/IxO8lo=', NULL, 0, 'student00032', '', '', 'student00032@example.edu.cn', 0, 1, '2025-05-18 07:00:17.220140');
INSERT INTO `auth_user` VALUES (436, 'pbkdf2_sha256$260000$67T7ax1BPc4Xy0IQRtbaGg$7dR3ROvn4uiGFjk07f06ItGm7noOY88//2a/Eserl2I=', NULL, 0, 'student00033', '', '', 'student00033@example.edu.cn', 0, 1, '2025-05-18 07:00:17.335140');
INSERT INTO `auth_user` VALUES (437, 'pbkdf2_sha256$260000$48Ol177pzn8T6BdfbVAxdQ$1IOJvB1JrPMy8LT1D8k0Rq7WveDqdR+1YSRK4038uLM=', NULL, 0, 'student00034', '', '', 'student00034@example.edu.cn', 0, 1, '2025-05-18 07:00:17.442138');
INSERT INTO `auth_user` VALUES (583, 'pbkdf2_sha256$260000$XRnpSmz1i36WbHsTlvyNce$iG7M8VSOnomKyt8RxJRmFCJUuzRoPklduJvldpYj7wg=', NULL, 0, 'student00180', '', '', 'student00180@example.edu.cn', 0, 1, '2025-05-18 07:00:33.392133');
INSERT INTO `auth_user` VALUES (582, 'pbkdf2_sha256$260000$btbYOOwUsSloMjqbnlgWVq$c2aiRpwkvjHs9IQkx7c7VZluAErzYihTvkjzuzIuJeY=', NULL, 0, 'student00179', '', '', 'student00179@example.edu.cn', 0, 1, '2025-05-18 07:00:33.285551');
INSERT INTO `auth_user` VALUES (581, 'pbkdf2_sha256$260000$DpibqONXri8GtNaPcorb92$h9wdQ6CytrWbjstzkwE2eroEdC97pDpRwY37VbDi4eo=', NULL, 0, 'student00178', '', '', 'student00178@example.edu.cn', 0, 1, '2025-05-18 07:00:33.179894');
INSERT INTO `auth_user` VALUES (580, 'pbkdf2_sha256$260000$MKVD0pR01ArfkvDbzJU7No$i4hqhrPhqKlgbW0+u/Z7B/ZtXQvbYeNIfPI+A2vrTxE=', NULL, 0, 'student00177', '', '', 'student00177@example.edu.cn', 0, 1, '2025-05-18 07:00:33.074507');
INSERT INTO `auth_user` VALUES (579, 'pbkdf2_sha256$260000$RMf5wm75ieSHXMwL5e7kOl$5WUXYun1kZaefiOT/kGwG2PFa90l3HkNapuaKZ7lYJ8=', NULL, 0, 'student00176', '', '', 'student00176@example.edu.cn', 0, 1, '2025-05-18 07:00:32.967827');
INSERT INTO `auth_user` VALUES (578, 'pbkdf2_sha256$260000$PY64OY0O6QmAjOHZcZa2EY$Y5/uesio9BIl+ba4ywspXagGRE9ECW+0id+D8WWMpnk=', NULL, 0, 'student00175', '', '', 'student00175@example.edu.cn', 0, 1, '2025-05-18 07:00:32.862323');
INSERT INTO `auth_user` VALUES (577, 'pbkdf2_sha256$260000$HU2ilDt4qpnKsiYEcE9Fmt$JskJCUmjbmCnz04JEOoY0az6rHXyBGKZtpA8UL7Nr3Q=', NULL, 0, 'student00174', '', '', 'student00174@example.edu.cn', 0, 1, '2025-05-18 07:00:32.753532');
INSERT INTO `auth_user` VALUES (576, 'pbkdf2_sha256$260000$yrxsaitDrfvgjVcgsQhNBq$n6gvAzuo1XMn41jMlEz21KAe3gkqklpQtznDJ88/e5g=', NULL, 0, 'student00173', '', '', 'student00173@example.edu.cn', 0, 1, '2025-05-18 07:00:32.643223');
INSERT INTO `auth_user` VALUES (575, 'pbkdf2_sha256$260000$rD5Ro6pMlsklvqKPzGxRIr$K0b2A9Hw+wF01LO70W3/RrBMVz4Io31PH/cCS1mlpq8=', NULL, 0, 'student00172', '', '', 'student00172@example.edu.cn', 0, 1, '2025-05-18 07:00:32.528079');
INSERT INTO `auth_user` VALUES (574, 'pbkdf2_sha256$260000$KrQL6xeyoLYE0GtgrKIkLX$uF1c9SFmhMgH/gbk+UslXcirKxUlXvNF0FHHEcdmJ/8=', NULL, 0, 'student00171', '', '', 'student00171@example.edu.cn', 0, 1, '2025-05-18 07:00:32.421360');
INSERT INTO `auth_user` VALUES (573, 'pbkdf2_sha256$260000$c6RdU9wq1BA02lSUCruPz4$07BAeQ2A7v9s+5ReHGGUPij8KH8mzwBGfvWHAU23zfY=', NULL, 0, 'student00170', '', '', 'student00170@example.edu.cn', 0, 1, '2025-05-18 07:00:32.313969');
INSERT INTO `auth_user` VALUES (572, 'pbkdf2_sha256$260000$EmpbIBMJGTlEuCzh212bJB$H0U9K71aUxeXASs1Tfha+7Q2HVzkEGKGRyUUVRfJl50=', NULL, 0, 'student00169', '', '', 'student00169@example.edu.cn', 0, 1, '2025-05-18 07:00:32.207979');
INSERT INTO `auth_user` VALUES (571, 'pbkdf2_sha256$260000$UG2n5bcVC8puhhNWDrcAEJ$xbbCTR68pTJYFEsPIuMHFhZ6RGziC+l2WhKESnZGGp0=', NULL, 0, 'student00168', '', '', 'student00168@example.edu.cn', 0, 1, '2025-05-18 07:00:32.098902');
INSERT INTO `auth_user` VALUES (570, 'pbkdf2_sha256$260000$0pQ1P6JLuao2bURhXXzfrU$2NzB+vlpD9lElcvEm0CR/jpc2DEaX7xbSQ3raSnHOW0=', NULL, 0, 'student00167', '', '', 'student00167@example.edu.cn', 0, 1, '2025-05-18 07:00:31.983598');
INSERT INTO `auth_user` VALUES (569, 'pbkdf2_sha256$260000$anxFz2EYO9ZxFK66x83HeE$L6Ht7g7tp9x7wTMSl9vfaAQGj+Vv10UNIEHmPQxpOD8=', NULL, 0, 'student00166', '', '', 'student00166@example.edu.cn', 0, 1, '2025-05-18 07:00:31.876887');
INSERT INTO `auth_user` VALUES (568, 'pbkdf2_sha256$260000$ayeKCFqgViK6iyGtA32Oaw$T4hqiiTbJ8m6QrOIQSvyfy0gUe5wuiXPo+ScvPs2ShA=', NULL, 0, 'student00165', '', '', 'student00165@example.edu.cn', 0, 1, '2025-05-18 07:00:31.770287');
INSERT INTO `auth_user` VALUES (567, 'pbkdf2_sha256$260000$yRFEa6Y7bqjTIAdV2b3SUx$RKorThqS3ohxq8n5mmFKBiPF9OcURIJC9LrJV62XthU=', NULL, 0, 'student00164', '', '', 'student00164@example.edu.cn', 0, 1, '2025-05-18 07:00:31.664187');
INSERT INTO `auth_user` VALUES (566, 'pbkdf2_sha256$260000$A7FQFHiAlHO2jBINjb28B6$QOsjtRrF/wYwn6xRzK0vikATnLoH1CbGq2zK51hbWqs=', NULL, 0, 'student00163', '', '', 'student00163@example.edu.cn', 0, 1, '2025-05-18 07:00:31.558419');
INSERT INTO `auth_user` VALUES (565, 'pbkdf2_sha256$260000$Zw14YKtEcUaK9cu2Ghoeop$vQJ7YCLiUiASvMHiiEGuUV7vWaBCjpgXcMVyFog9M0I=', NULL, 0, 'student00162', '', '', 'student00162@example.edu.cn', 0, 1, '2025-05-18 07:00:31.448776');
INSERT INTO `auth_user` VALUES (564, 'pbkdf2_sha256$260000$dZqAHn5rQmY2yOraa6SL1O$923hA+NsLL4UhejlwfUuLSZ3TwcROe226G14i0daITk=', NULL, 0, 'student00161', '', '', 'student00161@example.edu.cn', 0, 1, '2025-05-18 07:00:31.316236');
INSERT INTO `auth_user` VALUES (563, 'pbkdf2_sha256$260000$fyRSlyr5GUsjQ4I9siNxAr$0W7JJumckZfJRCMfO3xcMgHSKr0cRVQSeub4hsIbd4M=', NULL, 0, 'student00160', '', '', 'student00160@example.edu.cn', 0, 1, '2025-05-18 07:00:31.209236');
INSERT INTO `auth_user` VALUES (562, 'pbkdf2_sha256$260000$R0hykY2nziJ7P3QpsMWMms$wQXSJurvrlGG+UAjN/jyzRwm+y6T5scHs81CHRUNkjo=', NULL, 0, 'student00159', '', '', 'student00159@example.edu.cn', 0, 1, '2025-05-18 07:00:31.103237');
INSERT INTO `auth_user` VALUES (561, 'pbkdf2_sha256$260000$sKSxz7t3xEfKVtyegcnebG$+kw7+DzKI0R/N94Xdwo02Ybaqu3N4flok/5uUv3ieOI=', NULL, 0, 'student00158', '', '', 'student00158@example.edu.cn', 0, 1, '2025-05-18 07:00:30.997237');
INSERT INTO `auth_user` VALUES (560, 'pbkdf2_sha256$260000$Vnstc9sJ1SVSc09KgMSXxa$4RZGaSBZLMEcXRtMERT6qbolkXZ4xTD3uH/06BXsMF8=', NULL, 0, 'student00157', '', '', 'student00157@example.edu.cn', 0, 1, '2025-05-18 07:00:30.869238');
INSERT INTO `auth_user` VALUES (559, 'pbkdf2_sha256$260000$TmTemZzdE0MXQI94Adbf8j$Eqj8XwETtOlmjJkHr0HgVUTzMwnvF3Zs5MlwO8CqBsk=', NULL, 0, 'student00156', '', '', 'student00156@example.edu.cn', 0, 1, '2025-05-18 07:00:30.762238');
INSERT INTO `auth_user` VALUES (558, 'pbkdf2_sha256$260000$okQCv6WlxzmjuPfYmcUpqN$pYLI+NIIxfT1y7JtegNyyM2shE6xj75XUVzBoe1sH2A=', NULL, 0, 'student00155', '', '', 'student00155@example.edu.cn', 0, 1, '2025-05-18 07:00:30.656725');
INSERT INTO `auth_user` VALUES (557, 'pbkdf2_sha256$260000$uvGAkvprcUy38LIWR5jy0N$jWMDCkdGHOaECnUk2Ppp/9/Ox54eUrcUNznrDhOzwt4=', NULL, 0, 'student00154', '', '', 'student00154@example.edu.cn', 0, 1, '2025-05-18 07:00:30.549770');
INSERT INTO `auth_user` VALUES (556, 'pbkdf2_sha256$260000$OrjArKbF8QilukB9x0Xdb9$Ks3U+LyiQKcSu3F8PSOLhmP5EWlBUBt5uyWlcqrDLBw=', NULL, 0, 'student00153', '', '', 'student00153@example.edu.cn', 0, 1, '2025-05-18 07:00:30.434770');
INSERT INTO `auth_user` VALUES (555, 'pbkdf2_sha256$260000$EFBqvzqNUYYtgI0gfRVa8N$wxpiAIUotSgTJxeDihqsyVzj2jKdmB7IX1eznN9Sw1A=', NULL, 0, 'student00152', '', '', 'student00152@example.edu.cn', 0, 1, '2025-05-18 07:00:30.329176');
INSERT INTO `auth_user` VALUES (554, 'pbkdf2_sha256$260000$tIxdl6WtFiYu7aNcwIRjiz$zKm1Bsa+Ca1QazaOYLF7plx2vYXMwz8AkbpdItxXpCo=', NULL, 0, 'student00151', '', '', 'student00151@example.edu.cn', 0, 1, '2025-05-18 07:00:30.223299');
INSERT INTO `auth_user` VALUES (553, 'pbkdf2_sha256$260000$avDQTTzhwX7bcWgEDkocgE$x7Af7H8EsYH7dW80uOn2IHuECX8STuMmv0bX+4pl+PM=', NULL, 0, 'student00150', '', '', 'student00150@example.edu.cn', 0, 1, '2025-05-18 07:00:30.117299');
INSERT INTO `auth_user` VALUES (552, 'pbkdf2_sha256$260000$CLhMBUKl9xen6lyh42b73m$kqdrA8TPAXPuYoKIb664qGIrvptWBsaFKOHBAhoRWiY=', NULL, 0, 'student00149', '', '', 'student00149@example.edu.cn', 0, 1, '2025-05-18 07:00:30.011300');
INSERT INTO `auth_user` VALUES (551, 'pbkdf2_sha256$260000$qrtpTg17bveGaoL3BJ5XRb$Z1g5bC8ELW6AIbYk8UaLLCTVLGsP/u5K5bFtu61mG3s=', NULL, 0, 'student00148', '', '', 'student00148@example.edu.cn', 0, 1, '2025-05-18 07:00:29.905300');
INSERT INTO `auth_user` VALUES (550, 'pbkdf2_sha256$260000$huBzQBNZTVQWdfhddALiQW$CN/6wios562QikImSKA31oq5ndMtXNKTKMInTcGYJ2w=', NULL, 0, 'student00147', '', '', 'student00147@example.edu.cn', 0, 1, '2025-05-18 07:00:29.799301');
INSERT INTO `auth_user` VALUES (549, 'pbkdf2_sha256$260000$6C56RPSBAr8gdDV731295V$5JYbFjou5LX3A8f4PwCVUXfmlZeY3KSHi9sNP9i418w=', NULL, 0, 'student00146', '', '', 'student00146@example.edu.cn', 0, 1, '2025-05-18 07:00:29.688301');
INSERT INTO `auth_user` VALUES (548, 'pbkdf2_sha256$260000$VA73TWM55eBW5ysw5JSbNj$QZAKBJbzX8r03U94q3QAKnqsPN3ZeFJ8x6XqClSS+8c=', NULL, 0, 'student00145', '', '', 'student00145@example.edu.cn', 0, 1, '2025-05-18 07:00:29.581302');
INSERT INTO `auth_user` VALUES (547, 'pbkdf2_sha256$260000$XkACjN8Lencv8UVY5O6pXm$t6U40a/qje5CmBe47SeVAlBWn6hdHzHBolKaNvrvC8Q=', NULL, 0, 'student00144', '', '', 'student00144@example.edu.cn', 0, 1, '2025-05-18 07:00:29.475302');
INSERT INTO `auth_user` VALUES (546, 'pbkdf2_sha256$260000$YptYnf0tNmgw49qk2BtRjp$ynINIm4/Y//DmXNGiMnReEVmJnzPswtFxf2cXI5zyPc=', NULL, 0, 'student00143', '', '', 'student00143@example.edu.cn', 0, 1, '2025-05-18 07:00:29.368776');
INSERT INTO `auth_user` VALUES (545, 'pbkdf2_sha256$260000$xAGZXaztJEzbVAbLK87J02$kzLtbtZfACj+waVOIgL9TWeItTVGcMs69zb5S3jGHdg=', NULL, 0, 'student00142', '', '', 'student00142@example.edu.cn', 0, 1, '2025-05-18 07:00:29.260210');
INSERT INTO `auth_user` VALUES (544, 'pbkdf2_sha256$260000$GeKIu0cg4CCLpCjkYLvUwl$Mooczqu2Bptq+kTAONDo1Jb/fM4eQwPLEK+QKnd5214=', NULL, 0, 'student00141', '', '', 'student00141@example.edu.cn', 0, 1, '2025-05-18 07:00:29.148792');
INSERT INTO `auth_user` VALUES (543, 'pbkdf2_sha256$260000$NTtZFX9gmeSYVFwQyo7vHe$a6aAfcS59iiceZmx+NZCwRGf+JfG1yuEhoKfcwEjF3o=', NULL, 0, 'student00140', '', '', 'student00140@example.edu.cn', 0, 1, '2025-05-18 07:00:29.029810');
INSERT INTO `auth_user` VALUES (542, 'pbkdf2_sha256$260000$AkqGDTBzk9bkO5S07inKfk$jHab4dDWg7SeuU3Oxm/sL1RvcsqbpaX1Tr/uvBAcnKA=', NULL, 0, 'student00139', '', '', 'student00139@example.edu.cn', 0, 1, '2025-05-18 07:00:28.911193');
INSERT INTO `auth_user` VALUES (541, 'pbkdf2_sha256$260000$D6xb2U0Gfd3o17r7PHXP5E$sYf3GQNS2G20cMiy5bOmO1eGFbPF1nBiiBWc1JOKLsA=', NULL, 0, 'student00138', '', '', 'student00138@example.edu.cn', 0, 1, '2025-05-18 07:00:28.804652');
INSERT INTO `auth_user` VALUES (540, 'pbkdf2_sha256$260000$3a2Zoa1a7096werXlJtP6t$VAfuPsamS1J2HLcdLpaC/qKoZOkD/uVs8exP646GDUw=', NULL, 0, 'student00137', '', '', 'student00137@example.edu.cn', 0, 1, '2025-05-18 07:00:28.699595');
INSERT INTO `auth_user` VALUES (539, 'pbkdf2_sha256$260000$IScdg8uptISitzrQSAAeCp$IYzPrKMr8GAm1Z5M7Al1Bu3A786U+jfsnPSWdxrzzD0=', NULL, 0, 'student00136', '', '', 'student00136@example.edu.cn', 0, 1, '2025-05-18 07:00:28.593759');
INSERT INTO `auth_user` VALUES (538, 'pbkdf2_sha256$260000$7tfRyyuRtD3Z2OvHrqxSJq$3P9PM4UhUhX+oOl0P069DvhCSniSwPThEBSHyQL7VEk=', NULL, 0, 'student00135', '', '', 'student00135@example.edu.cn', 0, 1, '2025-05-18 07:00:28.486759');
INSERT INTO `auth_user` VALUES (537, 'pbkdf2_sha256$260000$wE5YTE8YaEWJWX5SUECIsD$p6SZIcO3Xkhi7Jb/4qCCG2v/rNSZ9bzeUNKfMe0wc4I=', NULL, 0, 'student00134', '', '', 'student00134@example.edu.cn', 0, 1, '2025-05-18 07:00:28.375245');
INSERT INTO `auth_user` VALUES (536, 'pbkdf2_sha256$260000$Hg273bCaYCaDQhM8ZPq40h$6RCRNDoC9JgXGs/LD0GxtdMZxSm4nOAqIgFLt9vB1yE=', NULL, 0, 'student00133', '', '', 'student00133@example.edu.cn', 0, 1, '2025-05-18 07:00:28.269588');
INSERT INTO `auth_user` VALUES (535, 'pbkdf2_sha256$260000$tb5hu0Wv7hSAmR7mddxDeD$V642MiJVt9ec3Yskq/ChR77PdimjmRZmoU/LDHM9LUc=', NULL, 0, 'student00132', '', '', 'student00132@example.edu.cn', 0, 1, '2025-05-18 07:00:28.162588');
INSERT INTO `auth_user` VALUES (534, 'pbkdf2_sha256$260000$tobqsW2qZl5KMwrdi9Uc88$QHq8O+Suh1bCynkklvHdCpixfKEIPxTFEqm1VfIi1k8=', NULL, 0, 'student00131', '', '', 'student00131@example.edu.cn', 0, 1, '2025-05-18 07:00:28.056589');
INSERT INTO `auth_user` VALUES (533, 'pbkdf2_sha256$260000$cFyJpMiqh1K2VJutYcSJRr$mxScrvFpz3fsswmM2tNhZHN0QWJAnzoQ+g653zDUyR4=', NULL, 0, 'student00130', '', '', 'student00130@example.edu.cn', 0, 1, '2025-05-18 07:00:27.949590');
INSERT INTO `auth_user` VALUES (532, 'pbkdf2_sha256$260000$SzBIZFeCS5WU4aNShEXigc$ihfRyNBcNC8wxz54LZt6E/I8oe5g1i8F+pd0eDHhno8=', NULL, 0, 'student00129', '', '', 'student00129@example.edu.cn', 0, 1, '2025-05-18 07:00:27.844506');
INSERT INTO `auth_user` VALUES (531, 'pbkdf2_sha256$260000$yk3d7BDkltAgI2qRBihfW9$aYvUnvCDeObl9JJDj3hZ680KdfmjdLl/7aXjeuQJuDM=', NULL, 0, 'student00128', '', '', 'student00128@example.edu.cn', 0, 1, '2025-05-18 07:00:27.737507');
INSERT INTO `auth_user` VALUES (530, 'pbkdf2_sha256$260000$Hj7jGRny2yNdVPmwjGW3np$0TDZ53rHbz3q3xigFkkj9QoOAAiCaHJXhTZfgmLUL6M=', NULL, 0, 'student00127', '', '', 'student00127@example.edu.cn', 0, 1, '2025-05-18 07:00:27.630507');
INSERT INTO `auth_user` VALUES (529, 'pbkdf2_sha256$260000$IK032qqx7EFp2mc49n4EeI$MGXDXwg6qOwJhQ+eAo2pB8XRzwW+KZRYcF/TBjhUTyk=', NULL, 0, 'student00126', '', '', 'student00126@example.edu.cn', 0, 1, '2025-05-18 07:00:27.516508');
INSERT INTO `auth_user` VALUES (528, 'pbkdf2_sha256$260000$f6KoaUdH3n3Ka5DNLo5BDa$jbL6BeJSOr33tpsd/pzaaeUDzVO7BokgfV1aTOPDVxo=', NULL, 0, 'student00125', '', '', 'student00125@example.edu.cn', 0, 1, '2025-05-18 07:00:27.409464');
INSERT INTO `auth_user` VALUES (527, 'pbkdf2_sha256$260000$AUKnIapDjd1GGFICWgd9mM$aWYEip71n9AXs2CWw+T+LL1k4bEFlOB6VgJjjspzpJw=', NULL, 0, 'student00124', '', '', 'student00124@example.edu.cn', 0, 1, '2025-05-18 07:00:27.301385');
INSERT INTO `auth_user` VALUES (526, 'pbkdf2_sha256$260000$hNIO6l79EaBI4xjGEWGaYz$h4FMkKck0aPHYdTrVl7ckYySC0saY0FQIX+X7w2LM+Q=', NULL, 0, 'student00123', '', '', 'student00123@example.edu.cn', 0, 1, '2025-05-18 07:00:27.186867');
INSERT INTO `auth_user` VALUES (525, 'pbkdf2_sha256$260000$OUrDnGRpMXqF3xgOoJVNdN$okIJ2zdyUCkpanPoM/SE8Yt/jAMBu7OPVAb0Ad95fL4=', NULL, 0, 'student00122', '', '', 'student00122@example.edu.cn', 0, 1, '2025-05-18 07:00:27.079433');
INSERT INTO `auth_user` VALUES (524, 'pbkdf2_sha256$260000$WSA9F4GzmMwi2WrqN2E2lo$7caqF81SizfI/icjqx4ettxIXFQcbBPlMpgObUNlsZI=', NULL, 0, 'student00121', '', '', 'student00121@example.edu.cn', 0, 1, '2025-05-18 07:00:26.973433');
INSERT INTO `auth_user` VALUES (523, 'pbkdf2_sha256$260000$dh3YjerjQN9Tm4nnRcOxtq$eOtKgWY7MzPo9Dv/M9dK6IqEf7ybrh+VAycnhT4XF0Y=', NULL, 0, 'student00120', '', '', 'student00120@example.edu.cn', 0, 1, '2025-05-18 07:00:26.867433');
INSERT INTO `auth_user` VALUES (522, 'pbkdf2_sha256$260000$SO9AewEoexK9CIVtYbyMtb$E7hOgc4Kd7ULH/3jz0gHa9oXuu4E7d/UIj6huZGYT8I=', NULL, 0, 'student00119', '', '', 'student00119@example.edu.cn', 0, 1, '2025-05-18 07:00:26.760434');
INSERT INTO `auth_user` VALUES (521, 'pbkdf2_sha256$260000$f8sX0xUhUP6JwptqYFhs5K$rOXGtPqak+oFYwfvhbnCpysoGJ9av0xnUNsZY2PvQqk=', NULL, 0, 'student00118', '', '', 'student00118@example.edu.cn', 0, 1, '2025-05-18 07:00:26.654434');
INSERT INTO `auth_user` VALUES (520, 'pbkdf2_sha256$260000$raGo7f2DljdAMWi3hBDdwp$l0JYaRr7i0nszG6wNZUyYe90LOAMfDQwjBI3zkyPd3Q=', NULL, 0, 'student00117', '', '', 'student00117@example.edu.cn', 0, 1, '2025-05-18 07:00:26.548434');
INSERT INTO `auth_user` VALUES (519, 'pbkdf2_sha256$260000$FTVFeFlfx7WJ6opv3EkJaB$7AofKkoj0l4/yBI0Jb2WoBFYxiz1gqaPGDloe1hEx/0=', NULL, 0, 'student00116', '', '', 'student00116@example.edu.cn', 0, 1, '2025-05-18 07:00:26.442435');
INSERT INTO `auth_user` VALUES (518, 'pbkdf2_sha256$260000$ByvO8CiiujEwK1CQzaj6X6$7S6sCESyow7pOduxD7Z+9tJWCHwMc+StDr6xlAk1UzM=', NULL, 0, 'student00115', '', '', 'student00115@example.edu.cn', 0, 1, '2025-05-18 07:00:26.337357');
INSERT INTO `auth_user` VALUES (584, 'pbkdf2_sha256$260000$xL4EtiJBSx0ixYrvqU5jwQ$3yr2bOcEgrw/vmMOug8uwlnfVzA4YwYcU2iJJ2eh1g0=', NULL, 0, 'student00181', '', '', 'student00181@example.edu.cn', 0, 1, '2025-05-18 07:00:33.498131');
INSERT INTO `auth_user` VALUES (585, 'pbkdf2_sha256$260000$uNXffbXUPtFK7qt8Td8kxk$OYGy9sdx9AS/aps2j+uYPBM1RSw6dbiI5lO7lCP6FiA=', NULL, 0, 'student00182', '', '', 'student00182@example.edu.cn', 0, 1, '2025-05-18 07:00:33.604137');
INSERT INTO `auth_user` VALUES (586, 'pbkdf2_sha256$260000$GKTWzyQbxj75yfhnmA1UJ2$sw6S9bwRXSrqfxTZ+yD+qDwVIHDAOvn478+eRzhSGbE=', NULL, 0, 'student00183', '', '', 'student00183@example.edu.cn', 0, 1, '2025-05-18 07:00:33.710131');
INSERT INTO `auth_user` VALUES (587, 'pbkdf2_sha256$260000$yfdWYqZiq5UGjKgjsr8avg$JuH/NvL0uHFYN6CsAp+3Rdate1OeFolRjvfTA7xmbfA=', NULL, 0, 'student00184', '', '', 'student00184@example.edu.cn', 0, 1, '2025-05-18 07:00:33.816724');
INSERT INTO `auth_user` VALUES (589, 'pbkdf2_sha256$260000$UO69AovxJN4PI4ZgezYhbv$W/wkFyYYsVhPA/j7bd0OOG07kVH21WIJr3vsPDBZKJQ=', NULL, 0, 'student00186', '', '', 'student00186@example.edu.cn', 0, 1, '2025-05-18 07:00:34.029801');
INSERT INTO `auth_user` VALUES (590, 'pbkdf2_sha256$260000$6lUleBUgUTHTJ5K6bQwz4r$m5a7fjBw3K7J+jC4da6qAo1c/CStS7ipxsvZ2eHVwQ4=', NULL, 0, 'student00187', '', '', 'student00187@example.edu.cn', 0, 1, '2025-05-18 07:00:34.157097');
INSERT INTO `auth_user` VALUES (591, 'pbkdf2_sha256$260000$Oz1G06EDeARTzflcUbnlen$1uuTRcw2NcBQ1gCjy4xXerLjeCGU7ynfkbH/IyGzHxU=', NULL, 0, 'student00188', '', '', 'student00188@example.edu.cn', 0, 1, '2025-05-18 07:00:34.267194');
INSERT INTO `auth_user` VALUES (592, 'pbkdf2_sha256$260000$su0CYUeVMDQknwdPkKwHjy$yWMxacsBV91atA9kzMp0oJHvZ0xVlgP1aBZ1xRLV4M0=', NULL, 0, 'student00189', '', '', 'student00189@example.edu.cn', 0, 1, '2025-05-18 07:00:34.374905');
INSERT INTO `auth_user` VALUES (593, 'pbkdf2_sha256$260000$L08d6kej2tixLEZ3E9uu06$9uPBKtcr847T/6ZVbpfZt2pKj3Sx8UGw/X/95LSfQ18=', NULL, 0, 'student00190', '', '', 'student00190@example.edu.cn', 0, 1, '2025-05-18 07:00:34.487079');
INSERT INTO `auth_user` VALUES (594, 'pbkdf2_sha256$260000$FSoKynIlr6qLep1Mf6Fa4M$pXEVOpqslzL/u44GMkq3h6GpnS8NkoD2WhP0jTU+DTI=', NULL, 0, 'student00191', '', '', 'student00191@example.edu.cn', 0, 1, '2025-05-18 07:00:34.613201');
INSERT INTO `auth_user` VALUES (595, 'pbkdf2_sha256$260000$hdThflXnxOudhf8Tip8b47$U9E15Rvvmoo03QXno5WMQy+P3s/aofC1lYDEag1RKko=', NULL, 0, 'student00192', '', '', 'student00192@example.edu.cn', 0, 1, '2025-05-18 07:00:34.746490');
INSERT INTO `auth_user` VALUES (612, 'pbkdf2_sha256$260000$ZISbVKQP80rG74bKtZcPUc$jOID7h7IKlWzn/YaSukYBjBAzS1MDc01mCTNDhqtMUQ=', '2025-05-19 10:07:52.882136', 0, 'test3333', '长得帅', '', 'test@test.com', 0, 1, '2025-05-19 10:06:52.816947');
INSERT INTO `auth_user` VALUES (597, 'pbkdf2_sha256$260000$ckOt36EC2E5zUyFHZsBneg$WQhHVySKdVNDDFYzkQp/rw2lT5kYhIqq7ruYd1mcFK0=', NULL, 0, 'student00194', '', '', 'student00194@example.edu.cn', 0, 1, '2025-05-18 07:00:34.973645');
INSERT INTO `auth_user` VALUES (598, 'pbkdf2_sha256$260000$blakAnQg810aQWajVyEHnz$TlaOgc3WVGureGOCeJT7N4mud7RaDWbRHzjaKQRcvtg=', NULL, 0, 'student00195', '', '', 'student00195@example.edu.cn', 0, 1, '2025-05-18 07:00:35.101264');
INSERT INTO `auth_user` VALUES (599, 'pbkdf2_sha256$260000$qVDqqt3VFxLsOrjOs9F4Cp$XADuni4dayIASeqajtHvttZM2CGwC+kxamsKU+L603U=', NULL, 0, 'student00196', '', '', 'student00196@example.edu.cn', 0, 1, '2025-05-18 07:00:35.215216');
INSERT INTO `auth_user` VALUES (600, 'pbkdf2_sha256$260000$dKy3hVl8y2ifN46EouR2xd$piRzyQRhiFO//7K6gMqUbatmcgb8KXvG40yx6dIP620=', NULL, 0, 'student00197', '', '', 'student00197@example.edu.cn', 0, 1, '2025-05-18 07:00:35.336723');
INSERT INTO `auth_user` VALUES (601, 'pbkdf2_sha256$260000$RGwBlaIlDCfJRRSfd525fv$5JGneKk9kRN0UeUbIBFfH+RkZxL53UXj1gYXyHPht6o=', NULL, 0, 'student00198', '', '', 'student00198@example.edu.cn', 0, 1, '2025-05-18 07:00:35.445746');
INSERT INTO `auth_user` VALUES (602, 'pbkdf2_sha256$260000$rOovKqZcJM4TlMnWQggH3s$ebGG4TvOJ15r8VPWhuHpqxQK8jxrtdiBy13KuWeIuck=', '2025-05-19 09:59:58.221104', 0, 'student00199', '', '', 'student00199@example.edu.cn', 0, 1, '2025-05-18 07:00:35.569772');
INSERT INTO `auth_user` VALUES (603, 'pbkdf2_sha256$260000$fEqxpZHS240KnloQK2y0ym$sypwCtXq3VeDKKWiPH41vcKFrZC3iTMnEI5eeIPnFSQ=', '2025-05-19 09:31:19.059561', 0, 'student00200', '', '', 'student00200@example.edu.cn', 0, 1, '2025-05-18 07:00:35.677939');
INSERT INTO `auth_user` VALUES (611, 'pbkdf2_sha256$260000$rvrJHThi1UdL6HOZjGM4dF$bGGfOKxT5BzLyvNIUkSCYlVAnedBaAX/O1YEBNoNiyM=', '2025-05-19 05:34:16.252160', 0, 'unde@gmail.com', 'aaabb', '', 'unde@gmail.com', 0, 1, '2025-05-19 05:33:58.009195');
INSERT INTO `auth_user` VALUES (605, 'pbkdf2_sha256$260000$IfnLjsbeGPNZgwcVmxHl17$EwsvjvKBH2a/JUqGxtf3rp+8wVznaYcsHzG9BRcofDM=', '2025-05-18 09:30:08.803086', 0, 'test111', '', '', 'unde@gmail.com', 0, 1, '2025-05-18 09:15:19.386737');
INSERT INTO `auth_user` VALUES (610, 'pbkdf2_sha256$260000$mSe8hLSsOBxkRKg8bFITec$bM6jRx46GqZoaGBxBcWVyuANx/ncE3B+1mAq8LtBw1k=', '2025-05-19 14:52:12.293265', 1, 'admin', '', '', 'admin@gamil.com', 1, 1, '2025-05-18 17:59:30.607900');
INSERT INTO `auth_user` VALUES (608, 'pbkdf2_sha256$260000$yMYSzY2RBevFuNlmmccg3i$ppRLhyTOdtee4ABoBpXkDj7LYTiaM9yGcQWF/6jsOdE=', '2025-05-18 17:19:43.387385', 0, 'test333', '测试用户222', '', 'paper1@juicex1n.xyz', 0, 1, '2025-05-18 17:19:36.502937');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_user_id_6a12ed8b`(`user_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544`(`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permissions_user_id_a95ead1b`(`user_id`) USING BTREE,
  INDEX `auth_user_user_permissions_permission_id_1fbb5f2c`(`permission_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'profile_app', 'modellog');
INSERT INTO `django_content_type` VALUES (8, 'profile_app', 'clusterresult');
INSERT INTO `django_content_type` VALUES (9, 'profile_app', 'studentrecord');
INSERT INTO `django_content_type` VALUES (10, 'profile_app', 'userprofile');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-03-05 12:12:36.142052');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2025-03-05 12:12:37.362913');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2025-03-05 12:12:37.629014');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-03-05 12:12:37.634014');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-05 12:12:37.639014');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2025-03-05 12:12:37.770551');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2025-03-05 12:12:37.830550');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2025-03-05 12:12:37.894245');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2025-03-05 12:12:37.899246');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2025-03-05 12:12:37.957113');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2025-03-05 12:12:37.959113');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2025-03-05 12:12:37.964113');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2025-03-05 12:12:38.018113');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2025-03-05 12:12:38.079113');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2025-03-05 12:12:38.143113');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2025-03-05 12:12:38.148113');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2025-03-05 12:12:38.208113');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2025-03-05 12:12:38.285113');
INSERT INTO `django_migrations` VALUES (25, 'profile_app', '0003_userprofile_student_id', '2025-05-18 05:30:47.047930');
INSERT INTO `django_migrations` VALUES (24, 'profile_app', '0002_auto_20250518_1221', '2025-05-18 04:22:13.801588');
INSERT INTO `django_migrations` VALUES (23, 'profile_app', '0001_initial', '2025-05-17 17:57:33.486134');
INSERT INTO `django_migrations` VALUES (26, 'profile_app', '0004_alter_userprofile_student_id', '2025-05-18 16:31:39.983641');
INSERT INTO `django_migrations` VALUES (27, 'profile_app', '0005_auto_20250519_0118', '2025-05-18 17:18:18.102896');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('3krwzjxw49fq7wwdtkno8b01j7kxyb1k', '.eJxVjDsOwjAQBe_iGlmbxF4DJT1niPZnEkC2lE-FuDtESgHtm5n3cj2ty9Cvs039qO7sEDp3-F2Z5GFlQ3qncqtealmmkf2m-J3O_lrVnpfd_TsYaB6-dZeySFIi5AApQtMGDSoAGg3JUg6IMTZ8aiVgNMFGj5RTAlbKwObeHzsIOOs:1uGZJD:t_96u0f-H1XOtTKFKpcFLQBZQZpxVaPYNAaPjn3L9rA', '2025-06-01 08:23:47.968420');
INSERT INTO `django_session` VALUES ('wtjfiouw46pmnfebj7lazg2k57ynrlg4', '.eJxVjEEOwiAQRe_C2hAKM0BduvcMhDKDVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWgzj9blNMD647oHustyZTq-syT3JX5EG7vDbi5-Vw_w5K7OVbR1CZlHcWbebkjUJCHI0FnSgr0KwdMiJE8shmGjwAgR-yoWS1G514fwDOdjcm:1uGWWI:ChypYfOKwnbrR9VfCUPpxKxw3N1_QHOtLRzNFoFHXu8', '2025-06-01 05:25:06.578556');
INSERT INTO `django_session` VALUES ('lp92lzjubb94iksfv8a4a3b9otpim3f3', '.eJxVjDsOwjAQBe_iGln-JP5Q0ucM1q53TQLIkeKkQtydREoB7cy89xYJtnVMW-MlTSSuQovLL0PIT66HoAfU-yzzXNdlQnkk8rRNDjPx63a2fwcjtHFfG_SEvQYL0Sifi2JbOEJWYWcOHWYT2OniOu5NR-TJYIRIShdtAyvx-QL4SzhQ:1uGWYr:q_v9TtcrrCaPAu7VsHrMiwHcvC8yF2Cjk1iOeNMFEm0', '2025-06-01 05:27:45.935996');
INSERT INTO `django_session` VALUES ('zsacoclvfobrqveospmalb053lg07wno', '.eJxVjDsOwyAQBe9CHSG-a5Myvc-AFliCkwgkY1dR7h5bcpG0b2bem3nc1uK3ToufE7syEIZdfteA8Un1QOmB9d54bHVd5sAPhZ-086klet1O9--gYC977Wy0MpMCEDZYQUYbGJJLSKBStppIuWjiKDDKnGEMkgi0CbszoAqSfb4wTTij:1uGbCi:Fd2L7-Xk8tjMajFzEW5oNSzK4GaSkDfRjHenfZXr_6Y', '2025-06-01 10:25:12.077653');
INSERT INTO `django_session` VALUES ('3s30nsjvu7oa3mdolym0jalymwafftk7', '.eJxVjEEOwiAQRe_C2hDoUGBcuvcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIszADi9LtG4kduO0p3ardZ8tzWZYpyV-RBu7zOKT8vh_t3UKnXb60K-JKBgZRjiNomPWqbnbbFGHaG0CrUQB5NQYuFEdhpSG70KeaBxfsDHqY37Q:1uGwsl:7w4_ao0pBJ4b0EHWTMbKVGjAUZVYboWwBlh1f5dt11M', '2025-06-02 09:34:03.107713');
INSERT INTO `django_session` VALUES ('j77dggc8gu645ulr01585l1tsu6jtdjm', '.eJxVjDsOwjAQBe_iGlmbxF4DJT1niPZnEkC2lE-FuDtESgHtm5n3cj2ty9Cvs039qO7sEDp3-F2Z5GFlQ3qncqtealmmkf2m-J3O_lrVnpfd_TsYaB6-dZeySFIi5AApQtMGDSoAGg3JUg6IMTZ8aiVgNMFGj5RTAlbKwObeHzsIOOs:1uGwq7:5xwWne695v6Fqf6flQ2nm_YtbUTy71LK6dowuqhis34', '2025-06-02 09:31:19.064000');
INSERT INTO `django_session` VALUES ('1qs5avrehzdi74tazvjaw7v95nd1j3gv', '.eJxVjEEOwiAQRe_C2hDoUGBcuvcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIszADi9LtG4kduO0p3ardZ8tzWZYpyV-RBu7zOKT8vh_t3UKnXb60K-JKBgZRjiNomPWqbnbbFGHaG0CrUQB5NQYuFEdhpSG70KeaBxfsDHqY37Q:1uGwqz:ltg-kl07h2O2d8_TyAh92e8ESePfYdemt1dNKPVO9Co', '2025-06-02 09:32:13.553910');
INSERT INTO `django_session` VALUES ('xr8cw4vwck1xri54wgehzc3kfct5wiaf', '.eJxVjMsOwiAQRf-FtSFAeQwu3fsNBIZBqgaS0q6M_65NutDtPefcFwtxW2vYBi1hzuzMtNLs9LumiA9qO8r32G6dY2_rMie-K_ygg197puflcP8Oahz1W0MCAQYEuojWqlKyAV0soi5eTkRRAFnhhMvSqAm9wUlaLN5IJ71RwN4fJ943lA:1uGwtA:2On1-QjCOhIjncdLqMzfqMp4Xilfe6p7ToVghzK3Gww', '2025-06-02 09:34:28.666834');
INSERT INTO `django_session` VALUES ('ebg7u6rz8ie94ueexzierp5b57hpp9d3', '.eJxVjMsOwiAQRf-FtSFAeQwu3fsNBIZBqgaS0q6M_65NutDtPefcFwtxW2vYBi1hzuzMtNLs9LumiA9qO8r32G6dY2_rMie-K_ygg197puflcP8Oahz1W0MCAQYEuojWqlKyAV0soi5eTkRRAFnhhMvSqAm9wUlaLN5IJ71RwN4fJ943lA:1uGwtS:pfD03oegmt_8OILNSRPlyLgyUrjg2HvaHD4Gexb9Uog', '2025-06-02 09:34:46.708813');
INSERT INTO `django_session` VALUES ('mui7d7k7iie6jyttzivs0j12gtz5pudf', '.eJxVjEEOwiAQRe_C2hCGUiEu3XsGMgOMVA0kpV0Z716adFG3773_v8LjumS_tjT7KYqbMBrE5UwJwzuVXcUXlmeVoZZlnkjuiTxsk48a0-d-tH8HGVvu66SYHYNhBSOriDYwoAWyWgXQMGhH4IakgotgugWiURt7xc46BPHbADRROAs:1uGwyL:Rxmaktq_cxyK78blXgpc3jkgBFTuFGFg3XM981pPyYI', '2025-06-02 09:39:49.808927');
INSERT INTO `django_session` VALUES ('rergrlyr5yfca9toxj1gjyy9w8mzi2x0', '.eJxVjEEOwiAURO_C2hCggMWle89ABv5HqqZNSrsy3t026UKXM-_NvEXEutS4Np7jQOIivFbi9Nsm5CePO6IHxvsk8zQu85DkrsiDNnmbiF_Xw_07qGh1W1tdQNr74FwxWzj3KvWcHWtjbEYCSkfOF3TcWQIHq1kpOG-LQQ4kPl83ETjm:1uH1qe:voHFwYH8Znn-7t__rLbO7K58iAEEuUOGiDvKJ2ljG4Y', '2025-06-02 14:52:12.297265');
INSERT INTO `django_session` VALUES ('9p2v7x1e4xqtmbs2uo35zs3wy5pkbb1k', '.eJxVjEEOwiAQRe_C2hCGUiEu3XsGMgOMVA0kpV0Z716adFG3773_v8LjumS_tjT7KYqbMBrE5UwJwzuVXcUXlmeVoZZlnkjuiTxsk48a0-d-tH8HGVvu66SYHYNhBSOriDYwoAWyWgXQMGhH4IakgotgugWiURt7xc46BPHbADRROAs:1uGxAv:SelrphglogRdJmbW5372HrYd8CiIZLilPmpy7OjCOIQ', '2025-06-02 09:52:49.568613');
INSERT INTO `django_session` VALUES ('0z4l8ot9iy1g80zzyci3h3029ed6udgs', 'e30:1uGxZw:tIPCy_xB_u-rtWj9gfGnoUWfkK09izD3Q8q2EKC92kI', '2025-06-02 10:18:40.573428');
INSERT INTO `django_session` VALUES ('p6kz2zt02kxl5n9nymn65xr6k7qheb5n', '.eJxVjEEOwiAURO_C2hCggMWle89ABv5HqqZNSrsy3t026UKXM-_NvEXEutS4Np7jQOIivFbi9Nsm5CePO6IHxvsk8zQu85DkrsiDNnmbiF_Xw_07qGh1W1tdQNr74FwxWzj3KvWcHWtjbEYCSkfOF3TcWQIHq1kpOG-LQQ4kPl83ETjm:1uH1eG:FdoRMwqnl3uQbTixQyqwqnR1zmyHh6pB-yKjqba-vNc', '2025-06-02 14:39:24.647547');

-- ----------------------------
-- Table structure for profile_app_clusterresult
-- ----------------------------
DROP TABLE IF EXISTS `profile_app_clusterresult`;
CREATE TABLE `profile_app_clusterresult`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `knowledge_dimension_score` double NOT NULL,
  `attitude_dimension_score` double NOT NULL,
  `interest_dimension_score` double NOT NULL,
  `final_score` double NOT NULL,
  `rating` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cluster_id` int(11) NULL DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `student_record_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `student_record_id`(`student_record_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2263 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of profile_app_clusterresult
-- ----------------------------
INSERT INTO `profile_app_clusterresult` VALUES (3862, 97.92061640271831, 82.70116220478955, 77.97673574347165, 89, '良好', 0, '2025-05-19 14:39:40.738458', '2025-05-19 14:39:40.738458', 402);
INSERT INTO `profile_app_clusterresult` VALUES (3861, 94.73711424284839, 67.71903975805628, 98.30155465412682, 87, '良好', 0, '2025-05-19 14:39:40.736458', '2025-05-19 14:39:40.736458', 403);
INSERT INTO `profile_app_clusterresult` VALUES (3860, 90.47993109640235, 88.64620951863873, 89.68891113456701, 90, '良好', 0, '2025-05-19 14:39:40.734459', '2025-05-19 14:39:40.734459', 404);
INSERT INTO `profile_app_clusterresult` VALUES (3859, 92.53405903043347, 90.13629152175358, 89.22315647638176, 91, '优秀', 0, '2025-05-19 14:39:40.732458', '2025-05-19 14:39:40.732458', 405);
INSERT INTO `profile_app_clusterresult` VALUES (3858, 100, 81.09847549046914, 85.33890815090582, 91, '优秀', 0, '2025-05-19 14:39:40.730458', '2025-05-19 14:39:40.730458', 406);
INSERT INTO `profile_app_clusterresult` VALUES (3857, 89.94429307662216, 92.58635091861805, 87.68116832215617, 90, '优秀', 0, '2025-05-19 14:39:40.729459', '2025-05-19 14:39:40.729459', 407);
INSERT INTO `profile_app_clusterresult` VALUES (3856, 83.77051803229396, 93.0971851311607, 96.67202836307422, 89, '良好', 0, '2025-05-19 14:39:40.727458', '2025-05-19 14:39:40.727458', 408);
INSERT INTO `profile_app_clusterresult` VALUES (3855, 95.75813544973317, 63.514124057690864, 96.07852277533193, 86, '良好', 0, '2025-05-19 14:39:40.725458', '2025-05-19 14:39:40.725458', 409);
INSERT INTO `profile_app_clusterresult` VALUES (3854, 100, 60.52920564598508, 100, 88, '良好', 0, '2025-05-19 14:39:40.723458', '2025-05-19 14:39:40.723458', 410);
INSERT INTO `profile_app_clusterresult` VALUES (3853, 79.52266383080864, 97.99878849891184, 71.71547956385506, 84, '良好', 0, '2025-05-19 14:39:40.721458', '2025-05-19 14:39:40.721458', 411);
INSERT INTO `profile_app_clusterresult` VALUES (3852, 63.67324750177112, 99.50790401632301, 81.99374866991614, 78, '良好', 0, '2025-05-19 14:39:40.719459', '2025-05-19 14:39:40.719459', 412);
INSERT INTO `profile_app_clusterresult` VALUES (3851, 100, 61.03298544512883, 92.5, 87, '良好', 0, '2025-05-19 14:39:40.717458', '2025-05-19 14:39:40.717458', 413);
INSERT INTO `profile_app_clusterresult` VALUES (3850, 96.14240908641476, 78.08208130057642, 78.30192151757535, 87, '良好', 0, '2025-05-19 14:39:40.715458', '2025-05-19 14:39:40.715458', 414);
INSERT INTO `profile_app_clusterresult` VALUES (3849, 96.74640332952075, 83.70601275167826, 82.4497064443824, 90, '良好', 0, '2025-05-19 14:39:40.713457', '2025-05-19 14:39:40.713457', 415);
INSERT INTO `profile_app_clusterresult` VALUES (3848, 97.71840415239976, 79.40372226462398, 78.65885930608532, 88, '良好', 0, '2025-05-19 14:39:40.711457', '2025-05-19 14:39:40.711457', 416);
INSERT INTO `profile_app_clusterresult` VALUES (3847, 98.24118980928094, 84.60602642486877, 86.25271208039952, 92, '优秀', 0, '2025-05-19 14:39:40.709457', '2025-05-19 14:39:40.709457', 417);
INSERT INTO `profile_app_clusterresult` VALUES (3846, 81.63626604977478, 89.64943955632563, 94, 87, '良好', 0, '2025-05-19 14:39:40.708457', '2025-05-19 14:39:40.708457', 418);
INSERT INTO `profile_app_clusterresult` VALUES (3845, 100, 64.83058548546835, 96.97904514008923, 89, '良好', 0, '2025-05-19 14:39:40.706457', '2025-05-19 14:39:40.706457', 419);
INSERT INTO `profile_app_clusterresult` VALUES (3844, 61.858530309760425, 100, 81.51774691060372, 77, '良好', 0, '2025-05-19 14:39:40.704458', '2025-05-19 14:39:40.704458', 420);
INSERT INTO `profile_app_clusterresult` VALUES (3843, 97.99819462105214, 78.26572223240784, 83.965302129756, 89, '良好', 0, '2025-05-19 14:39:40.702010', '2025-05-19 14:39:40.702010', 421);
INSERT INTO `profile_app_clusterresult` VALUES (3842, 92.37422507832193, 75.96839629790604, 74.66693186315857, 84, '良好', 0, '2025-05-19 14:39:40.700000', '2025-05-19 14:39:40.700000', 422);
INSERT INTO `profile_app_clusterresult` VALUES (3841, 97.87045219801816, 84.43593833389343, 79.45764153868618, 90, '优秀', 0, '2025-05-19 14:39:40.698112', '2025-05-19 14:39:40.698112', 423);
INSERT INTO `profile_app_clusterresult` VALUES (3840, 98.80196797484126, 81.53728554967223, 86.9325399598375, 91, '优秀', 0, '2025-05-19 14:39:40.696112', '2025-05-19 14:39:40.696112', 424);
INSERT INTO `profile_app_clusterresult` VALUES (3839, 97.68352056715739, 90.41346828090936, 91.06515589713516, 94, '优秀', 0, '2025-05-19 14:39:40.694112', '2025-05-19 14:39:40.694112', 425);
INSERT INTO `profile_app_clusterresult` VALUES (3838, 83.3698885557683, 90.56751431429224, 94, 88, '良好', 0, '2025-05-19 14:39:40.692112', '2025-05-19 14:39:40.692112', 426);
INSERT INTO `profile_app_clusterresult` VALUES (3837, 100, 82.55418964756238, 80.9233976049574, 91, '优秀', 0, '2025-05-19 14:39:40.691112', '2025-05-19 14:39:40.691112', 427);
INSERT INTO `profile_app_clusterresult` VALUES (3836, 84.241273668648, 82.36862687491276, 95.5, 86, '良好', 0, '2025-05-19 14:39:40.689112', '2025-05-19 14:39:40.689112', 428);
INSERT INTO `profile_app_clusterresult` VALUES (3835, 79.3478986933266, 88.23077604071652, 97, 86, '良好', 0, '2025-05-19 14:39:40.687111', '2025-05-19 14:39:40.687111', 429);
INSERT INTO `profile_app_clusterresult` VALUES (3834, 95.11169967401693, 62.92434699437946, 100, 86, '良好', 0, '2025-05-19 14:39:40.685112', '2025-05-19 14:39:40.685112', 430);
INSERT INTO `profile_app_clusterresult` VALUES (3833, 98.20530183140747, 57.81172970073883, 95.5, 86, '良好', 0, '2025-05-19 14:39:40.683111', '2025-05-19 14:39:40.683111', 431);
INSERT INTO `profile_app_clusterresult` VALUES (3832, 96.3457198897489, 65.2102062274829, 71.04414378144978, 82, '良好', 0, '2025-05-19 14:39:40.681112', '2025-05-19 14:39:40.681112', 432);
INSERT INTO `profile_app_clusterresult` VALUES (3831, 85.01478915939498, 54.90566240958245, 76.19472320971339, 74, '良好', 0, '2025-05-19 14:39:40.679111', '2025-05-19 14:39:40.679111', 433);
INSERT INTO `profile_app_clusterresult` VALUES (3830, 57.37078074083074, 91.7250451801214, 69.41154335234731, 70, '良好', 0, '2025-05-19 14:39:40.677112', '2025-05-19 14:39:40.677112', 434);
INSERT INTO `profile_app_clusterresult` VALUES (3829, 58.85955648659441, 92.81455478077203, 63.17145327642349, 70, '中等', 0, '2025-05-19 14:39:40.675111', '2025-05-19 14:39:40.675111', 435);
INSERT INTO `profile_app_clusterresult` VALUES (3828, 65.67860910674369, 73.85912999599509, 86.5, 72, '良好', 0, '2025-05-19 14:39:40.673111', '2025-05-19 14:39:40.673111', 436);
INSERT INTO `profile_app_clusterresult` VALUES (3827, 67.45023170190301, 77.71528986036097, 74.10111624888296, 72, '良好', 0, '2025-05-19 14:39:40.671111', '2025-05-19 14:39:40.671111', 437);
INSERT INTO `profile_app_clusterresult` VALUES (3826, 68.83565249036181, 76.15552422706791, 80.27457333925497, 73, '良好', 0, '2025-05-19 14:39:40.669112', '2025-05-19 14:39:40.669112', 438);
INSERT INTO `profile_app_clusterresult` VALUES (3825, 92.02020563886133, 70.22511696675726, 71.44894982265059, 81, '良好', 0, '2025-05-19 14:39:40.667111', '2025-05-19 14:39:40.667111', 439);
INSERT INTO `profile_app_clusterresult` VALUES (3824, 68.92506406258713, 74.05087770842188, 74.67385871714467, 72, '良好', 0, '2025-05-19 14:39:40.665111', '2025-05-19 14:39:40.665111', 440);
INSERT INTO `profile_app_clusterresult` VALUES (3823, 84.03586103048346, 58.077380961349874, 78.46728844935208, 75, '良好', 0, '2025-05-19 14:39:40.663111', '2025-05-19 14:39:40.663111', 441);
INSERT INTO `profile_app_clusterresult` VALUES (3822, 58.41137368403219, 82.5429565328753, 81.54855024543102, 70, '良好', 0, '2025-05-19 14:39:40.661111', '2025-05-19 14:39:40.661111', 442);
INSERT INTO `profile_app_clusterresult` VALUES (3821, 70.86475658789811, 85.3191251281663, 68.19535280885664, 75, '良好', 0, '2025-05-19 14:39:40.659111', '2025-05-19 14:39:40.659111', 443);
INSERT INTO `profile_app_clusterresult` VALUES (3820, 70.46489516027337, 45.609031595259964, 79.82839782249937, 65, '中等', 0, '2025-05-19 14:39:40.657110', '2025-05-19 14:39:40.657110', 444);
INSERT INTO `profile_app_clusterresult` VALUES (3819, 63.624688440385455, 78.32021947471563, 80.9944304394601, 72, '良好', 0, '2025-05-19 14:39:40.655110', '2025-05-19 14:39:40.655110', 445);
INSERT INTO `profile_app_clusterresult` VALUES (3818, 76.75309894043782, 74.91758518439978, 72.83378866319413, 75, '良好', 0, '2025-05-19 14:39:40.653110', '2025-05-19 14:39:40.653110', 446);
INSERT INTO `profile_app_clusterresult` VALUES (3817, 70.19702552202176, 90.29561916764439, 70.85920215879844, 76, '良好', 0, '2025-05-19 14:39:40.651110', '2025-05-19 14:39:40.651110', 447);
INSERT INTO `profile_app_clusterresult` VALUES (3816, 73.9268258880273, 77.99811811885624, 74.68472434280889, 75, '良好', 0, '2025-05-19 14:39:40.650110', '2025-05-19 14:39:40.650110', 448);
INSERT INTO `profile_app_clusterresult` VALUES (3815, 75.44718234546716, 72.25171415245272, 74.3185065246019, 74, '良好', 0, '2025-05-19 14:39:40.648110', '2025-05-19 14:39:40.648110', 449);
INSERT INTO `profile_app_clusterresult` VALUES (3814, 77.96106927859128, 75.06715534431947, 82, 78, '良好', 0, '2025-05-19 14:39:40.646110', '2025-05-19 14:39:40.646110', 450);
INSERT INTO `profile_app_clusterresult` VALUES (3813, 60.7964271307106, 81.53482422362593, 59.68410941442516, 67, '中等', 0, '2025-05-19 14:39:40.644110', '2025-05-19 14:39:40.644110', 451);
INSERT INTO `profile_app_clusterresult` VALUES (3812, 77.3018790836522, 48.96046830700791, 81.48677094019507, 70, '中等', 0, '2025-05-19 14:39:40.642110', '2025-05-19 14:39:40.642110', 452);
INSERT INTO `profile_app_clusterresult` VALUES (3811, 55.21340141473264, 94.6828352272575, 68.9193002445033, 70, '中等', 0, '2025-05-19 14:39:40.640110', '2025-05-19 14:39:40.640110', 453);
INSERT INTO `profile_app_clusterresult` VALUES (3810, 93.80348396587767, 74.44366159966461, 67.23053065278735, 83, '良好', 0, '2025-05-19 14:39:40.638109', '2025-05-19 14:39:40.638109', 454);
INSERT INTO `profile_app_clusterresult` VALUES (3809, 85.65235432222016, 50.32439239767828, 82, 74, '良好', 0, '2025-05-19 14:39:40.636110', '2025-05-19 14:39:40.636110', 456);
INSERT INTO `profile_app_clusterresult` VALUES (3808, 76.23207519709348, 76.59992720042369, 71.80155957740814, 75, '良好', 0, '2025-05-19 14:39:40.634110', '2025-05-19 14:39:40.634110', 457);
INSERT INTO `profile_app_clusterresult` VALUES (3807, 96.65278922876337, 75.42649548617024, 66.21441277151928, 84, '良好', 0, '2025-05-19 14:39:40.632109', '2025-05-19 14:39:40.632109', 458);
INSERT INTO `profile_app_clusterresult` VALUES (3806, 73.79166631680846, 81.36514478113835, 66.56746430495745, 75, '良好', 0, '2025-05-19 14:39:40.630110', '2025-05-19 14:39:40.630110', 459);
INSERT INTO `profile_app_clusterresult` VALUES (3805, 88.94305882018828, 66.2180774662635, 63.336010065985406, 77, '良好', 0, '2025-05-19 14:39:40.628109', '2025-05-19 14:39:40.628109', 460);
INSERT INTO `profile_app_clusterresult` VALUES (3804, 71.20333315505785, 84.20793811246908, 85, 78, '良好', 0, '2025-05-19 14:39:40.626109', '2025-05-19 14:39:40.626109', 461);
INSERT INTO `profile_app_clusterresult` VALUES (3803, 60.41835668584079, 81.83750921199531, 80.5, 71, '良好', 0, '2025-05-19 14:39:40.625109', '2025-05-19 14:39:40.625109', 462);
INSERT INTO `profile_app_clusterresult` VALUES (3802, 67.26114038627881, 88.1958743446701, 56.50333767522134, 71, '良好', 0, '2025-05-19 14:39:40.623109', '2025-05-19 14:39:40.623109', 463);
INSERT INTO `profile_app_clusterresult` VALUES (3801, 67.41473825816023, 93.00860505562461, 57.17722444478071, 73, '良好', 0, '2025-05-19 14:39:40.621109', '2025-05-19 14:39:40.621109', 464);
INSERT INTO `profile_app_clusterresult` VALUES (3800, 80.52703295755339, 74.703054725925, 77.15442574423545, 78, '良好', 0, '2025-05-19 14:39:40.619109', '2025-05-19 14:39:40.619109', 465);
INSERT INTO `profile_app_clusterresult` VALUES (3799, 99.86866513813035, 77.45004142459351, 67.5674652898335, 87, '良好', 0, '2025-05-19 14:39:40.617109', '2025-05-19 14:39:40.617109', 466);
INSERT INTO `profile_app_clusterresult` VALUES (3798, 94.03061470014278, 65.85842551475301, 65.63399884459196, 80, '良好', 0, '2025-05-19 14:39:40.615109', '2025-05-19 14:39:40.615109', 467);
INSERT INTO `profile_app_clusterresult` VALUES (3797, 84.1543862054967, 53.440145999004685, 77.95839187299242, 74, '良好', 0, '2025-05-19 14:39:40.613109', '2025-05-19 14:39:40.613109', 468);
INSERT INTO `profile_app_clusterresult` VALUES (3792, 58.04030114338088, 90.90373007588042, 67.04036734536966, 70, '中等', 0, '2025-05-19 14:39:40.603108', '2025-05-19 14:39:40.603108', 473);
INSERT INTO `profile_app_clusterresult` VALUES (3793, 70.90708543700794, 74.6583051418802, 76.39360599059478, 73, '良好', 0, '2025-05-19 14:39:40.605108', '2025-05-19 14:39:40.605108', 472);
INSERT INTO `profile_app_clusterresult` VALUES (3794, 81.79159226175507, 65.80439089947714, 73.39187130516203, 75, '良好', 0, '2025-05-19 14:39:40.607109', '2025-05-19 14:39:40.607109', 471);
INSERT INTO `profile_app_clusterresult` VALUES (3796, 90.10556133709511, 55.83490820353628, 77.88655887465254, 77, '良好', 0, '2025-05-19 14:39:40.611109', '2025-05-19 14:39:40.611109', 469);
INSERT INTO `profile_app_clusterresult` VALUES (3795, 89.7606088067783, 64.57556700006079, 74.19070964872783, 79, '良好', 0, '2025-05-19 14:39:40.609108', '2025-05-19 14:39:40.609108', 470);
INSERT INTO `profile_app_clusterresult` VALUES (3791, 75.01063538837457, 80.5090730725842, 69.4945475894161, 76, '良好', 0, '2025-05-19 14:39:40.601108', '2025-05-19 14:39:40.601108', 474);
INSERT INTO `profile_app_clusterresult` VALUES (3790, 69.80726430194234, 86.0226312944649, 65.43610118684853, 74, '良好', 0, '2025-05-19 14:39:40.598108', '2025-05-19 14:39:40.598108', 475);
INSERT INTO `profile_app_clusterresult` VALUES (3789, 68.62832611285936, 88.75921504313943, 69.10425972218628, 75, '良好', 0, '2025-05-19 14:39:40.596108', '2025-05-19 14:39:40.596108', 476);
INSERT INTO `profile_app_clusterresult` VALUES (3780, 86.32031628135579, 61.10004748069353, 56.58023991779765, 73, '良好', 0, '2025-05-19 14:39:40.579108', '2025-05-19 14:39:40.579108', 485);
INSERT INTO `profile_app_clusterresult` VALUES (3781, 46.88373540402347, 74.95346053238482, 46.28887671936997, 55, '中等', 1, '2025-05-19 14:39:40.581107', '2025-05-19 14:39:40.581107', 484);
INSERT INTO `profile_app_clusterresult` VALUES (3782, 58.07334930169689, 63.28146871216041, 56.17129953654448, 59, '中等', 1, '2025-05-19 14:39:40.583107', '2025-05-19 14:39:40.583107', 483);
INSERT INTO `profile_app_clusterresult` VALUES (3783, 55.41069997561429, 47.621879255406625, 65.78268269665095, 55, '中等', 1, '2025-05-19 14:39:40.585108', '2025-05-19 14:39:40.585108', 482);
INSERT INTO `profile_app_clusterresult` VALUES (3784, 74.74575191835166, 71.99318605621283, 67.65882760285098, 73, '良好', 0, '2025-05-19 14:39:40.587107', '2025-05-19 14:39:40.587107', 481);
INSERT INTO `profile_app_clusterresult` VALUES (3785, 96.18299349091691, 68.60347864188981, 67.60711011351657, 82, '良好', 0, '2025-05-19 14:39:40.589108', '2025-05-19 14:39:40.589108', 480);
INSERT INTO `profile_app_clusterresult` VALUES (3786, 100, 77.37452710257371, 66.86908977395484, 87, '良好', 0, '2025-05-19 14:39:40.591108', '2025-05-19 14:39:40.591108', 479);
INSERT INTO `profile_app_clusterresult` VALUES (3788, 71.44707968749233, 71.98103684930629, 78.9839973192221, 73, '良好', 0, '2025-05-19 14:39:40.595108', '2025-05-19 14:39:40.595108', 477);
INSERT INTO `profile_app_clusterresult` VALUES (3787, 92.89033463864601, 66.89065816722504, 69.39084346068131, 80, '良好', 0, '2025-05-19 14:39:40.593108', '2025-05-19 14:39:40.593108', 478);
INSERT INTO `profile_app_clusterresult` VALUES (3779, 42.74065065344264, 77.62658495195679, 50.98070610988567, 55, '中等', 1, '2025-05-19 14:39:40.577108', '2025-05-19 14:39:40.577108', 486);
INSERT INTO `profile_app_clusterresult` VALUES (3778, 48.43919058723271, 61.36257115526408, 65.6842407203087, 56, '中等', 1, '2025-05-19 14:39:40.575107', '2025-05-19 14:39:40.575107', 487);
INSERT INTO `profile_app_clusterresult` VALUES (3777, 83.07288971874736, 59.092074722088974, 59.52453398177177, 71, '良好', 0, '2025-05-19 14:39:40.573107', '2025-05-19 14:39:40.573107', 488);
INSERT INTO `profile_app_clusterresult` VALUES (3776, 54.754948149130726, 62.62064551497105, 60.24780910424947, 58, '中等', 1, '2025-05-19 14:39:40.571107', '2025-05-19 14:39:40.571107', 489);
INSERT INTO `profile_app_clusterresult` VALUES (3775, 59.575087448276946, 56.17583155771938, 58.55470138277184, 58, '中等', 1, '2025-05-19 14:39:40.569107', '2025-05-19 14:39:40.569107', 490);
INSERT INTO `profile_app_clusterresult` VALUES (3774, 62.858622512435566, 58.68721551769169, 64.16795966358748, 62, '中等', 0, '2025-05-19 14:39:40.567107', '2025-05-19 14:39:40.567107', 491);
INSERT INTO `profile_app_clusterresult` VALUES (3773, 50.51449113669322, 78.00033394748132, 54.31882378669091, 60, '中等', 0, '2025-05-19 14:39:40.565107', '2025-05-19 14:39:40.565107', 492);
INSERT INTO `profile_app_clusterresult` VALUES (3772, 44.388941929259175, 78.14992830393847, 54.148540327801285, 56, '中等', 0, '2025-05-19 14:39:40.563106', '2025-05-19 14:39:40.563106', 493);
INSERT INTO `profile_app_clusterresult` VALUES (3771, 97.12511211116066, 52.45332803967879, 57.40920467197999, 76, '良好', 0, '2025-05-19 14:39:40.561106', '2025-05-19 14:39:40.561106', 494);
INSERT INTO `profile_app_clusterresult` VALUES (3770, 61.89851227672996, 63.586738051761934, 64.92692074216856, 63, '中等', 0, '2025-05-19 14:39:40.559106', '2025-05-19 14:39:40.559106', 495);
INSERT INTO `profile_app_clusterresult` VALUES (3769, 61.931839953845625, 67.44020365144586, 48.44547444535773, 61, '中等', 0, '2025-05-19 14:39:40.557106', '2025-05-19 14:39:40.557106', 496);
INSERT INTO `profile_app_clusterresult` VALUES (3768, 50.716942952496545, 49.81489460802027, 59.767190400891224, 52, '中等', 1, '2025-05-19 14:39:40.555106', '2025-05-19 14:39:40.555106', 497);
INSERT INTO `profile_app_clusterresult` VALUES (3767, 56.704835920232874, 58.92099044581366, 50.86694805221089, 56, '中等', 1, '2025-05-19 14:39:40.553106', '2025-05-19 14:39:40.553106', 498);
INSERT INTO `profile_app_clusterresult` VALUES (3766, 53.6085538985995, 56.13741142736359, 45.6564547623667, 53, '中等', 1, '2025-05-19 14:39:40.552106', '2025-05-19 14:39:40.552106', 499);
INSERT INTO `profile_app_clusterresult` VALUES (3765, 46.29146625576602, 58.51832921518188, 68.82784470147976, 54, '中等', 1, '2025-05-19 14:39:40.550106', '2025-05-19 14:39:40.550106', 500);
INSERT INTO `profile_app_clusterresult` VALUES (3764, 65.50184141075296, 60.33686010705926, 48.24215034659864, 61, '中等', 1, '2025-05-19 14:39:40.548106', '2025-05-19 14:39:40.548106', 501);
INSERT INTO `profile_app_clusterresult` VALUES (3763, 55.22328623564162, 50.64294486305661, 66.41722547155422, 56, '中等', 1, '2025-05-19 14:39:40.546106', '2025-05-19 14:39:40.546106', 502);
INSERT INTO `profile_app_clusterresult` VALUES (3762, 76.16677519873203, 52.72607471088052, 56.09358095732591, 65, '中等', 0, '2025-05-19 14:39:40.544105', '2025-05-19 14:39:40.544105', 503);
INSERT INTO `profile_app_clusterresult` VALUES (3761, 55.77212600629025, 62.95222145413106, 46.91316006083545, 56, '中等', 1, '2025-05-19 14:39:40.542105', '2025-05-19 14:39:40.542105', 504);
INSERT INTO `profile_app_clusterresult` VALUES (3760, 51.182782016506664, 60.202208709164374, 74.4827969961183, 59, '中等', 0, '2025-05-19 14:39:40.540106', '2025-05-19 14:39:40.540106', 505);
INSERT INTO `profile_app_clusterresult` VALUES (3759, 52.16754059716098, 74.12291442454026, 61.660455855582114, 61, '中等', 0, '2025-05-19 14:39:40.538105', '2025-05-19 14:39:40.538105', 506);
INSERT INTO `profile_app_clusterresult` VALUES (3758, 90.37362925161696, 47.41341203032397, 44.84362719271027, 68, '中等', 0, '2025-05-19 14:39:40.536105', '2025-05-19 14:39:40.536105', 507);
INSERT INTO `profile_app_clusterresult` VALUES (3757, 72.86503008852422, 45.39659059180342, 65.17368503444312, 63, '中等', 1, '2025-05-19 14:39:40.534105', '2025-05-19 14:39:40.534105', 508);
INSERT INTO `profile_app_clusterresult` VALUES (3756, 63.31311919776034, 36.50707597192135, 57.3846737151042, 54, '中等', 1, '2025-05-19 14:39:40.532105', '2025-05-19 14:39:40.532105', 509);
INSERT INTO `profile_app_clusterresult` VALUES (3755, 95.75999281081542, 59.758920905816936, 46.30604437626329, 75, '良好', 0, '2025-05-19 14:39:40.530105', '2025-05-19 14:39:40.531105', 510);
INSERT INTO `profile_app_clusterresult` VALUES (3754, 69.74839781325417, 54.15113117851, 59.824815991691686, 63, '中等', 0, '2025-05-19 14:39:40.529105', '2025-05-19 14:39:40.529105', 511);
INSERT INTO `profile_app_clusterresult` VALUES (3753, 58.86532875006142, 47.9436298671662, 64.98443413381545, 57, '中等', 1, '2025-05-19 14:39:40.527105', '2025-05-19 14:39:40.527105', 512);
INSERT INTO `profile_app_clusterresult` VALUES (3752, 69.14938447259948, 68.0858578153841, 53.33170624923618, 66, '中等', 0, '2025-05-19 14:39:40.525106', '2025-05-19 14:39:40.525106', 513);
INSERT INTO `profile_app_clusterresult` VALUES (3751, 67.65989887850272, 46.619722760026676, 48.64476313115063, 58, '中等', 1, '2025-05-19 14:39:40.523105', '2025-05-19 14:39:40.523105', 514);
INSERT INTO `profile_app_clusterresult` VALUES (3750, 72.25350399860582, 56.329649555472, 47.650127764256396, 63, '中等', 1, '2025-05-19 14:39:40.521105', '2025-05-19 14:39:40.521105', 515);
INSERT INTO `profile_app_clusterresult` VALUES (3749, 76.86942089830457, 51.08038434502122, 47.834205711277534, 63, '中等', 1, '2025-05-19 14:39:40.519105', '2025-05-19 14:39:40.519105', 516);
INSERT INTO `profile_app_clusterresult` VALUES (3748, 75.12763370589182, 36.81534971884055, 43.25815886121276, 57, '中等', 1, '2025-05-19 14:39:40.517104', '2025-05-19 14:39:40.517104', 517);
INSERT INTO `profile_app_clusterresult` VALUES (3747, 56.57172516377825, 56.36198327852563, 68.81210943461504, 59, '中等', 1, '2025-05-19 14:39:40.515104', '2025-05-19 14:39:40.515104', 518);
INSERT INTO `profile_app_clusterresult` VALUES (3746, 60.7030628137918, 54.71383295805322, 51.964366248485746, 57, '中等', 1, '2025-05-19 14:39:40.513105', '2025-05-19 14:39:40.513105', 519);
INSERT INTO `profile_app_clusterresult` VALUES (3745, 53.662627916050305, 65.6913720641007, 68.01941580268193, 60, '中等', 0, '2025-05-19 14:39:40.511104', '2025-05-19 14:39:40.511104', 520);
INSERT INTO `profile_app_clusterresult` VALUES (3744, 77.862811562188, 52.5408952944196, 55.162151826397334, 66, '中等', 0, '2025-05-19 14:39:40.509104', '2025-05-19 14:39:40.509104', 521);
INSERT INTO `profile_app_clusterresult` VALUES (3743, 55.2087418336089, 34.84516269267475, 54.41261249000617, 49, '待提高', 1, '2025-05-19 14:39:40.507104', '2025-05-19 14:39:40.507104', 522);
INSERT INTO `profile_app_clusterresult` VALUES (3742, 62.61767719625611, 76.13347868336383, 60.73454381983296, 66, '中等', 0, '2025-05-19 14:39:40.506104', '2025-05-19 14:39:40.506104', 523);
INSERT INTO `profile_app_clusterresult` VALUES (3741, 34.45537885593377, 70.02831023771739, 34.50008356670853, 45, '待提高', 1, '2025-05-19 14:39:40.504104', '2025-05-19 14:39:40.504104', 524);
INSERT INTO `profile_app_clusterresult` VALUES (3740, 57.84099985160585, 42.68611445332493, 63.17136942366652, 54, '中等', 1, '2025-05-19 14:39:40.502104', '2025-05-19 14:39:40.502104', 525);
INSERT INTO `profile_app_clusterresult` VALUES (3739, 74.93057730306477, 45.219016620392836, 60.66710226644566, 63, '中等', 1, '2025-05-19 14:39:40.500104', '2025-05-19 14:39:40.500104', 526);
INSERT INTO `profile_app_clusterresult` VALUES (3738, 75.81315307976881, 61.95740070607829, 55.21250524881226, 68, '中等', 0, '2025-05-19 14:39:40.498104', '2025-05-19 14:39:40.498104', 527);
INSERT INTO `profile_app_clusterresult` VALUES (3737, 59.827408182639246, 50.303079134051046, 54.792441956102444, 56, '中等', 1, '2025-05-19 14:39:40.496103', '2025-05-19 14:39:40.496103', 528);
INSERT INTO `profile_app_clusterresult` VALUES (3736, 84.02178511198322, 57.03036614191505, 52.98736109596255, 70, '中等', 0, '2025-05-19 14:39:40.494103', '2025-05-19 14:39:40.494103', 529);
INSERT INTO `profile_app_clusterresult` VALUES (3735, 78.94701799679918, 42.93831441290939, 53.67851227636772, 63, '中等', 1, '2025-05-19 14:39:40.492103', '2025-05-19 14:39:40.492103', 530);
INSERT INTO `profile_app_clusterresult` VALUES (3727, 62.54359896799198, 60.67956946912986, 44.633642499644864, 58, '中等', 1, '2025-05-19 14:39:40.477103', '2025-05-19 14:39:40.477103', 538);
INSERT INTO `profile_app_clusterresult` VALUES (3728, 77.48556041878923, 42.04671628064149, 53.843770304292974, 62, '中等', 1, '2025-05-19 14:39:40.479103', '2025-05-19 14:39:40.479103', 537);
INSERT INTO `profile_app_clusterresult` VALUES (3729, 64.06157107644687, 64.75811050772423, 61.774778848470056, 64, '中等', 0, '2025-05-19 14:39:40.480103', '2025-05-19 14:39:40.480103', 536);
INSERT INTO `profile_app_clusterresult` VALUES (3730, 69.38849867563738, 46.40697947283396, 61.25170498240401, 61, '中等', 1, '2025-05-19 14:39:40.482103', '2025-05-19 14:39:40.482103', 535);
INSERT INTO `profile_app_clusterresult` VALUES (3731, 62.71120834840269, 59.622217911666695, 67.09202004425636, 63, '中等', 0, '2025-05-19 14:39:40.484103', '2025-05-19 14:39:40.484103', 534);
INSERT INTO `profile_app_clusterresult` VALUES (3732, 63.59411963071494, 43.03486685418131, 55.639333616593376, 56, '中等', 1, '2025-05-19 14:39:40.486103', '2025-05-19 14:39:40.486103', 533);
INSERT INTO `profile_app_clusterresult` VALUES (3733, 55.078653110156196, 42.02980481451739, 57.617287224371424, 52, '中等', 1, '2025-05-19 14:39:40.488103', '2025-05-19 14:39:40.488103', 532);
INSERT INTO `profile_app_clusterresult` VALUES (3734, 55.6679252956728, 52.796421679514026, 60.2507328596853, 56, '中等', 1, '2025-05-19 14:39:40.490103', '2025-05-19 14:39:40.490103', 531);
INSERT INTO `profile_app_clusterresult` VALUES (3726, 67.92814904777096, 68.89789375639545, 43.89212875706466, 63, '中等', 0, '2025-05-19 14:39:40.475103', '2025-05-19 14:39:40.475103', 539);
INSERT INTO `profile_app_clusterresult` VALUES (3725, 47.28749264964952, 57.486098004868936, 60.433425317417885, 53, '中等', 1, '2025-05-19 14:39:40.473103', '2025-05-19 14:39:40.473103', 540);
INSERT INTO `profile_app_clusterresult` VALUES (3724, 39.44161520332897, 63.17481412567153, 60.037134653410575, 51, '中等', 1, '2025-05-19 14:39:40.471103', '2025-05-19 14:39:40.471103', 541);
INSERT INTO `profile_app_clusterresult` VALUES (3718, 56.7572534526864, 72.88379097943287, 52.62108892805464, 61, '中等', 0, '2025-05-19 14:39:40.459102', '2025-05-19 14:39:40.459102', 547);
INSERT INTO `profile_app_clusterresult` VALUES (3719, 83.42547423000195, 49.454503162603686, 45.46642251093754, 66, '中等', 0, '2025-05-19 14:39:40.461102', '2025-05-19 14:39:40.461102', 546);
INSERT INTO `profile_app_clusterresult` VALUES (3720, 65.08731377607425, 38.255992427989845, 66.27175648977321, 57, '中等', 1, '2025-05-19 14:39:40.463102', '2025-05-19 14:39:40.463102', 545);
INSERT INTO `profile_app_clusterresult` VALUES (3721, 67.63258175360494, 54.71829297264682, 67.19799029200351, 64, '中等', 0, '2025-05-19 14:39:40.465102', '2025-05-19 14:39:40.465102', 544);
INSERT INTO `profile_app_clusterresult` VALUES (3723, 48.121834462611005, 76.6743366539991, 56.365237282376484, 58, '中等', 0, '2025-05-19 14:39:40.469102', '2025-05-19 14:39:40.469102', 542);
INSERT INTO `profile_app_clusterresult` VALUES (3722, 60.149326414469535, 55.65451665433169, 45.80589740944218, 56, '中等', 1, '2025-05-19 14:39:40.467102', '2025-05-19 14:39:40.467102', 543);
INSERT INTO `profile_app_clusterresult` VALUES (3717, 50.60049365584988, 57.175808083238934, 66.44305610381504, 56, '中等', 1, '2025-05-19 14:39:40.457102', '2025-05-19 14:39:40.457102', 548);
INSERT INTO `profile_app_clusterresult` VALUES (3716, 74.34407455344953, 59.20832889746591, 60.13451119649606, 67, '中等', 0, '2025-05-19 14:39:40.455102', '2025-05-19 14:39:40.455102', 549);
INSERT INTO `profile_app_clusterresult` VALUES (3715, 50.59129300209304, 66.59785397883192, 69.38599291204707, 59, '中等', 0, '2025-05-19 14:39:40.453102', '2025-05-19 14:39:40.453102', 550);
INSERT INTO `profile_app_clusterresult` VALUES (3714, 56.994709061835096, 54.711907842858615, 56.43000489871059, 56, '中等', 1, '2025-05-19 14:39:40.451101', '2025-05-19 14:39:40.451101', 551);
INSERT INTO `profile_app_clusterresult` VALUES (3710, 26.138434813731266, 60.9310707180296, 28.608246359778406, 37, '待提高', 1, '2025-05-19 14:39:40.444101', '2025-05-19 14:39:40.444101', 555);
INSERT INTO `profile_app_clusterresult` VALUES (3711, 36.86268426356351, 49.611102895529925, 32.71876134359689, 40, '待提高', 1, '2025-05-19 14:39:40.445101', '2025-05-19 14:39:40.445101', 554);
INSERT INTO `profile_app_clusterresult` VALUES (3712, 54.44704607687006, 30.68317755239571, 46.149271523912546, 46, '待提高', 1, '2025-05-19 14:39:40.448102', '2025-05-19 14:39:40.448102', 553);
INSERT INTO `profile_app_clusterresult` VALUES (3713, 56.57015240322363, 26.198391932697348, 42.038064917745075, 45, '待提高', 1, '2025-05-19 14:39:40.449102', '2025-05-19 14:39:40.449102', 552);
INSERT INTO `profile_app_clusterresult` VALUES (3708, 60.9995998214594, 35.999218586855356, 38.014837604647816, 49, '待提高', 1, '2025-05-19 14:39:40.440101', '2025-05-19 14:39:40.440101', 557);
INSERT INTO `profile_app_clusterresult` VALUES (3709, 59.170309446154334, 33.01387437390448, 36.58953158950338, 47, '待提高', 1, '2025-05-19 14:39:40.442101', '2025-05-19 14:39:40.442101', 556);
INSERT INTO `profile_app_clusterresult` VALUES (3707, 48.19788098881679, 34.241354965800326, 38.194147653996964, 42, '待提高', 1, '2025-05-19 14:39:40.438101', '2025-05-19 14:39:40.438101', 558);
INSERT INTO `profile_app_clusterresult` VALUES (3706, 45.78212624558337, 32.79645109190531, 45.58853824477869, 42, '待提高', 1, '2025-05-19 14:39:40.436101', '2025-05-19 14:39:40.436101', 559);
INSERT INTO `profile_app_clusterresult` VALUES (3705, 44.64072149504, 45.522521876778114, 34.01690163925666, 43, '待提高', 1, '2025-05-19 14:39:40.434101', '2025-05-19 14:39:40.434101', 560);
INSERT INTO `profile_app_clusterresult` VALUES (3704, 65.14679407866518, 41.46804931458863, 39.320716909360115, 53, '中等', 1, '2025-05-19 14:39:40.432100', '2025-05-19 14:39:40.432100', 561);
INSERT INTO `profile_app_clusterresult` VALUES (3703, 35.33349838578261, 55.78209338737453, 35.183889017933865, 41, '待提高', 1, '2025-05-19 14:39:40.430102', '2025-05-19 14:39:40.430102', 562);
INSERT INTO `profile_app_clusterresult` VALUES (3702, 49.10398319881315, 44.01053383896836, 37.66758508558165, 45, '待提高', 1, '2025-05-19 14:39:40.428100', '2025-05-19 14:39:40.428100', 563);
INSERT INTO `profile_app_clusterresult` VALUES (3701, 39.84656968205054, 40.40506357202273, 38.415459143212146, 40, '待提高', 1, '2025-05-19 14:39:40.426100', '2025-05-19 14:39:40.426100', 564);
INSERT INTO `profile_app_clusterresult` VALUES (3700, 41.432376144785586, 36.84282990451706, 31.798931900644394, 38, '待提高', 1, '2025-05-19 14:39:40.424100', '2025-05-19 14:39:40.424100', 565);
INSERT INTO `profile_app_clusterresult` VALUES (3699, 57.259289225993555, 52.92094296759704, 37.30046513255627, 52, '中等', 1, '2025-05-19 14:39:40.422100', '2025-05-19 14:39:40.422100', 566);
INSERT INTO `profile_app_clusterresult` VALUES (3698, 59.97025168784116, 29.66935443629853, 28.89494480418125, 45, '待提高', 1, '2025-05-19 14:39:40.420100', '2025-05-19 14:39:40.420100', 567);
INSERT INTO `profile_app_clusterresult` VALUES (3697, 65.6697459543652, 40.34901525125477, 35.44587230952977, 52, '中等', 1, '2025-05-19 14:39:40.418100', '2025-05-19 14:39:40.418100', 568);
INSERT INTO `profile_app_clusterresult` VALUES (3696, 50.94501165421349, 38.04061591054429, 42.651007579232015, 45, '待提高', 1, '2025-05-19 14:39:40.416100', '2025-05-19 14:39:40.416100', 569);
INSERT INTO `profile_app_clusterresult` VALUES (3695, 63.763775936264324, 29.203951432504052, 41.684743713301, 49, '待提高', 1, '2025-05-19 14:39:40.414100', '2025-05-19 14:39:40.414100', 570);
INSERT INTO `profile_app_clusterresult` VALUES (3694, 48.30346623966344, 49.77717316497611, 29.886709039954425, 45, '待提高', 1, '2025-05-19 14:39:40.412100', '2025-05-19 14:39:40.412100', 571);
INSERT INTO `profile_app_clusterresult` VALUES (3693, 38.174248883091124, 40.1033939075039, 45.5507072994546, 40, '待提高', 1, '2025-05-19 14:39:40.410100', '2025-05-19 14:39:40.410100', 572);
INSERT INTO `profile_app_clusterresult` VALUES (3692, 56.6378516078887, 34.697119510411085, 40.4909945910798, 47, '待提高', 1, '2025-05-19 14:39:40.408100', '2025-05-19 14:39:40.408100', 573);
INSERT INTO `profile_app_clusterresult` VALUES (3691, 55.67881116769736, 39.247492062589735, 35.0272298508622, 47, '待提高', 1, '2025-05-19 14:39:40.405101', '2025-05-19 14:39:40.405101', 574);
INSERT INTO `profile_app_clusterresult` VALUES (3686, 34.58947863959821, 65.1067310049372, 34.23855381396768, 44, '待提高', 1, '2025-05-19 14:39:40.395099', '2025-05-19 14:39:40.395099', 579);
INSERT INTO `profile_app_clusterresult` VALUES (3687, 30.732922551172233, 46.799270768638884, 48.044134309240576, 39, '待提高', 1, '2025-05-19 14:39:40.397099', '2025-05-19 14:39:40.397099', 578);
INSERT INTO `profile_app_clusterresult` VALUES (3688, 32.52233509720851, 52.839224824051655, 28.408694504883293, 38, '待提高', 1, '2025-05-19 14:39:40.399100', '2025-05-19 14:39:40.399100', 577);
INSERT INTO `profile_app_clusterresult` VALUES (3689, 60.48999838988589, 28.35461920775222, 43.5283765578524, 47, '待提高', 1, '2025-05-19 14:39:40.401099', '2025-05-19 14:39:40.401099', 576);
INSERT INTO `profile_app_clusterresult` VALUES (3690, 47.445853443063754, 26.42583149406606, 36.77136299339543, 39, '待提高', 1, '2025-05-19 14:39:40.403099', '2025-05-19 14:39:40.403099', 575);
INSERT INTO `profile_app_clusterresult` VALUES (3684, 47.947947768698555, 26.239218396362205, 39.609809948100754, 40, '待提高', 1, '2025-05-19 14:39:40.391099', '2025-05-19 14:39:40.391099', 581);
INSERT INTO `profile_app_clusterresult` VALUES (3685, 38.754141405290696, 43.124970779038684, 49.857736001442504, 42, '待提高', 1, '2025-05-19 14:39:40.393099', '2025-05-19 14:39:40.393099', 580);
INSERT INTO `profile_app_clusterresult` VALUES (3683, 30.469341435723862, 30.360176149596114, 22.375711164415584, 29, '待提高', 1, '2025-05-19 14:39:40.389099', '2025-05-19 14:39:40.389099', 582);
INSERT INTO `profile_app_clusterresult` VALUES (3682, 25.639467114629184, 30.75938489809169, 17.974206313353573, 26, '待提高', 1, '2025-05-19 14:39:40.387099', '2025-05-19 14:39:40.387099', 583);
INSERT INTO `profile_app_clusterresult` VALUES (3681, 18.93755589682197, 24.890983971404687, 15.25041689476716, 20, '待提高', 1, '2025-05-19 14:39:40.385099', '2025-05-19 14:39:40.385099', 584);
INSERT INTO `profile_app_clusterresult` VALUES (3680, 34.35316925038966, 30.088181453850773, 13.963321359452884, 29, '待提高', 1, '2025-05-19 14:39:40.383098', '2025-05-19 14:39:40.383098', 585);
INSERT INTO `profile_app_clusterresult` VALUES (3679, 25.404482678730368, 34.80454512974717, 22.668105196705582, 28, '待提高', 1, '2025-05-19 14:39:40.381099', '2025-05-19 14:39:40.381099', 587);
INSERT INTO `profile_app_clusterresult` VALUES (3677, 31.89087658659806, 35.64664876853214, 30.495959792048417, 33, '待提高', 1, '2025-05-19 14:39:40.376099', '2025-05-19 14:39:40.376099', 589);
INSERT INTO `profile_app_clusterresult` VALUES (3678, 38.03567636819855, 24.111913239614275, 26.514688694037197, 32, '待提高', 1, '2025-05-19 14:39:40.378099', '2025-05-19 14:39:40.378099', 588);
INSERT INTO `profile_app_clusterresult` VALUES (3675, 33.67934447335788, 23.849290171188322, 23.198129529756415, 29, '待提高', 1, '2025-05-19 14:39:40.372098', '2025-05-19 14:39:40.372098', 591);
INSERT INTO `profile_app_clusterresult` VALUES (3676, 27.49220045001323, 25.604775163835015, 29.197452497175895, 27, '待提高', 1, '2025-05-19 14:39:40.374099', '2025-05-19 14:39:40.374099', 590);
INSERT INTO `profile_app_clusterresult` VALUES (3674, 26.659752757228453, 29.150750369245888, 15.983336055773051, 25, '待提高', 1, '2025-05-19 14:39:40.370098', '2025-05-19 14:39:40.370098', 592);
INSERT INTO `profile_app_clusterresult` VALUES (3673, 39.4608570063192, 28.494046918154666, 24.27138493809439, 33, '待提高', 1, '2025-05-19 14:39:40.368098', '2025-05-19 14:39:40.368098', 593);
INSERT INTO `profile_app_clusterresult` VALUES (3672, 45.13001001509368, 25.236218588624645, 24.320779417907197, 35, '待提高', 1, '2025-05-19 14:39:40.366098', '2025-05-19 14:39:40.366098', 595);
INSERT INTO `profile_app_clusterresult` VALUES (3671, 35.002181099413065, 17.799767302400806, 25.957794178320203, 28, '待提高', 1, '2025-05-19 14:39:40.364098', '2025-05-19 14:39:40.364098', 596);
INSERT INTO `profile_app_clusterresult` VALUES (3670, 20.57958831352188, 39.214795805022725, 15.670432382734418, 25, '待提高', 1, '2025-05-19 14:39:40.362097', '2025-05-19 14:39:40.362097', 597);
INSERT INTO `profile_app_clusterresult` VALUES (3669, 25.905926683589414, 38.64955245073589, 15.644279086964794, 28, '待提高', 1, '2025-05-19 14:39:40.360098', '2025-05-19 14:39:40.360098', 598);
INSERT INTO `profile_app_clusterresult` VALUES (3668, 25.709978155304682, 26.732458823619865, 12.508652655995155, 23, '待提高', 1, '2025-05-19 14:39:40.357098', '2025-05-19 14:39:40.357098', 599);
INSERT INTO `profile_app_clusterresult` VALUES (3667, 35.80446609181119, 31.933397565088523, 18.754260670103204, 31, '待提高', 1, '2025-05-19 14:39:40.355097', '2025-05-19 14:39:40.355097', 600);
INSERT INTO `profile_app_clusterresult` VALUES (3666, 15.3, 24, 39.3, 23, '待提高', 1, '2025-05-19 14:39:40.353097', '2025-05-19 14:39:40.353097', 603);
INSERT INTO `profile_app_clusterresult` VALUES (3663, 29.4, 20.7, 29.3, 27, '待提高', 1, '2025-05-19 14:39:40.347097', '2025-05-19 14:39:40.347097', 609);
INSERT INTO `profile_app_clusterresult` VALUES (3665, 47, 47, 32.5, 44, '待提高', 1, '2025-05-19 14:39:40.351097', '2025-05-19 14:39:40.351097', 606);
INSERT INTO `profile_app_clusterresult` VALUES (3664, 91.5, 96.2, 96, 94, '优秀', 0, '2025-05-19 14:39:40.349097', '2025-05-19 14:39:40.349097', 608);

-- ----------------------------
-- Table structure for profile_app_modellog
-- ----------------------------
DROP TABLE IF EXISTS `profile_app_modellog`;
CREATE TABLE `profile_app_modellog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `train_time` datetime(6) NOT NULL,
  `model_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `parameters` json NULL,
  `performance_metrics` json NULL,
  `notes` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of profile_app_modellog
-- ----------------------------
INSERT INTO `profile_app_modellog` VALUES (11, '2025-05-18 08:33:12.968562', 'KMeans', NULL, '{\"total_sse\": 936.6759656365572, \"sample_count\": 201, \"silhouette_score\": 0.3714971065346292}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (10, '2025-05-18 08:02:23.012504', 'KMeans', NULL, '{\"total_sse\": 936.6759656365572, \"sample_count\": 201, \"silhouette_score\": 0.3714971065346292}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (9, '2025-05-18 08:02:22.561332', 'KMeans', NULL, '{\"total_sse\": 936.6759656365572, \"sample_count\": 201, \"silhouette_score\": 0.3714971065346292}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (8, '2025-05-18 07:04:50.494341', 'KMeans', NULL, '{\"total_sse\": 936.6759656365572, \"sample_count\": 201, \"silhouette_score\": 0.3714971065346292}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (7, '2025-05-18 07:00:37.154144', 'KMeans', NULL, '{\"total_sse\": 941.4468512516283, \"sample_count\": 200, \"silhouette_score\": 0.3692354044557406}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (12, '2025-05-18 09:40:27.870668', 'KMeans', NULL, '{\"total_sse\": 935.3339226184823, \"sample_count\": 201, \"silhouette_score\": 0.3768710689309176}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (13, '2025-05-18 09:40:38.749608', 'KMeans', NULL, '{\"total_sse\": 935.3339226184823, \"sample_count\": 201, \"silhouette_score\": 0.3768710689309176}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (14, '2025-05-18 15:47:18.496954', 'KMeans', NULL, '{\"total_sse\": 940.304189784556, \"sample_count\": 200, \"silhouette_score\": 0.36951061683302727}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (15, '2025-05-18 18:11:00.776769', 'KMeans', NULL, '{\"total_sse\": 946.698107288984, \"sample_count\": 201, \"silhouette_score\": 0.3680112597316371}', '聚类分析完成，处理了 201 条记录。');
INSERT INTO `profile_app_modellog` VALUES (16, '2025-05-19 04:53:37.446958', 'KMeans', NULL, '{\"total_sse\": 954.066898248724, \"sample_count\": 200, \"silhouette_score\": 0.3694249950899608}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (17, '2025-05-19 04:56:28.241697', 'KMeans', NULL, '{\"total_sse\": 953.381752731698, \"sample_count\": 200, \"silhouette_score\": 0.36890612013515406}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (18, '2025-05-19 05:38:55.800877', 'KMeans', NULL, '{\"total_sse\": 940.8907663939884, \"sample_count\": 200, \"silhouette_score\": 0.36831425237776144}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (19, '2025-05-19 06:11:24.244729', 'KMeans', NULL, '{\"total_sse\": 939.6435116716666, \"sample_count\": 199, \"silhouette_score\": 0.3671730842737303}', '聚类分析完成，处理了 199 条记录。');
INSERT INTO `profile_app_modellog` VALUES (20, '2025-05-19 06:11:56.675725', 'KMeans', NULL, '{\"total_sse\": 939.9273702946676, \"sample_count\": 200, \"silhouette_score\": 0.3686182986790314}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (21, '2025-05-19 10:05:58.262392', 'KMeans', NULL, '{\"total_sse\": 939.9273702946676, \"sample_count\": 200, \"silhouette_score\": 0.3686182986790314}', '聚类分析完成，处理了 200 条记录。');
INSERT INTO `profile_app_modellog` VALUES (22, '2025-05-19 14:39:40.740458', 'KMeans', NULL, '{\"total_sse\": 939.9273702946676, \"sample_count\": 200, \"silhouette_score\": 0.3686182986790314}', '聚类分析完成，处理了 200 条记录。');

-- ----------------------------
-- Table structure for profile_app_studentrecord
-- ----------------------------
DROP TABLE IF EXISTS `profile_app_studentrecord`;
CREATE TABLE `profile_app_studentrecord`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `homework_score` double NOT NULL,
  `training_pass_rate` double NOT NULL,
  `test_completion_rate` double NOT NULL,
  `sign_in_score` double NOT NULL,
  `homework_completion_rate` double NOT NULL,
  `video_watch_rate` double NOT NULL,
  `test_completion_count` int(11) NOT NULL,
  `homework_completion_count` int(11) NOT NULL,
  `course_interaction_score` double NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `profile_app_studentrecord_user_id_d61a591d`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 605 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of profile_app_studentrecord
-- ----------------------------
INSERT INTO `profile_app_studentrecord` VALUES (500, 51.84260115345148, 0.43902105990833284, 0.4127931332378478, 55.82836276060336, 0.7035086876636916, 0.45431576268177365, 6, 11, 85.81961175369938, '2025-05-18 07:00:24.697345', '2025-05-18 07:00:24.697345', 502);
INSERT INTO `profile_app_studentrecord` VALUES (600, 35.65353785768694, 0.3324809591149889, 0.38562073917622486, 36.42312627374035, 0.26098148144950023, 0.35224001416621353, 1, 4, 24.385651675258007, '2025-05-18 07:00:35.674938', '2025-05-18 07:00:35.674938', 602);
INSERT INTO `profile_app_studentrecord` VALUES (499, 45.37528001492365, 0.570913586477897, 0.6110344766097708, 54.189747042335554, 0.5687999696084777, 0.5709496176774603, 6, 10, 31.641136905916753, '2025-05-18 07:00:24.588345', '2025-05-18 07:00:24.589345', 501);
INSERT INTO `profile_app_studentrecord` VALUES (498, 56.03406205189804, 0.528180579817214, 0.6148597901652412, 60.41320558241011, 0.7095567484833774, 0.41382529439185123, 5, 10, 52.16737013052721, '2025-05-18 07:00:24.468832', '2025-05-18 07:00:24.468832', 500);
INSERT INTO `profile_app_studentrecord` VALUES (497, 48.02222102067909, 0.4877747236902985, 0.5624937611171985, 49.920877694339694, 0.5256192714193552, 0.4604620147648052, 4, 14, 66.91797600222806, '2025-05-18 07:00:24.336726', '2025-05-18 07:00:24.336726', 499);
INSERT INTO `profile_app_studentrecord` VALUES (496, 51.75153856392885, 0.696292842157865, 0.6780813087846045, 67.1953363993172, 0.6923536057389669, 0.6529152834030671, 5, 14, 31.113686113394337, '2025-05-18 07:00:24.229878', '2025-05-18 07:00:24.229878', 498);
INSERT INTO `profile_app_studentrecord` VALUES (495, 69.51867668107559, 0.6140700974277609, 0.5222979560488966, 63.97693382108168, 0.6616156337623871, 0.597634418498065, 5, 12, 79.81730185542139, '2025-05-18 07:00:24.124453', '2025-05-18 07:00:24.124453', 497);
INSERT INTO `profile_app_studentrecord` VALUES (494, 94.80790072861981, 0.9733983939904246, 1, 46.85403459414683, 0.48735840625091453, 0.630092713713272, 5, 14, 53.523011679949974, '2025-05-18 07:00:24.019453', '2025-05-18 07:00:24.019453', 496);
INSERT INTO `profile_app_studentrecord` VALUES (493, 32.884500302118596, 0.43596895107414374, 0.6052024425395809, 79.79712187827958, 0.7613737363106668, 0.7918614096009305, 6, 12, 45.3713508195032, '2025-05-18 07:00:23.911339', '2025-05-18 07:00:23.911339', 495);
INSERT INTO `profile_app_studentrecord` VALUES (492, 58.36878758008199, 0.5205026820334031, 0.3850631881219445, 82.52668594185897, 0.6971205911543401, 0.8452501506250004, 6, 11, 49.54705946672729, '2025-05-18 07:00:23.803340', '2025-05-18 07:00:23.803340', 494);
INSERT INTO `profile_app_studentrecord` VALUES (491, 66.1989760595403, 0.6772717471697315, 0.53536265578425, 63.541200678089346, 0.5803736636912505, 0.5469969588871624, 6, 14, 62.91989915896869, '2025-05-18 07:00:23.688340', '2025-05-18 07:00:23.688340', 493);
INSERT INTO `profile_app_studentrecord` VALUES (490, 56.03385249146481, 0.6343600501700957, 0.6043581648862718, 66.37352963489722, 0.4103795508872227, 0.6616196877253765, 5, 14, 56.38675345692959, '2025-05-18 07:00:23.580341', '2025-05-18 07:00:23.580341', 492);
INSERT INTO `profile_app_studentrecord` VALUES (489, 64.62956545384435, 0.5222318704331004, 0.4412055284866658, 51.15195233171369, 0.8277235417236721, 0.472203938217002, 6, 13, 56.86952276062367, '2025-05-18 07:00:23.473341', '2025-05-18 07:00:23.473341', 491);
INSERT INTO `profile_app_studentrecord` VALUES (488, 77.96770604976412, 0.8149997847819354, 0.9145271251794551, 61.939626317719416, 0.6555880441174189, 0.47622216873587986, 4, 13, 70.06133495442941, '2025-05-18 07:00:23.365342', '2025-05-18 07:00:23.365342', 490);
INSERT INTO `profile_app_studentrecord` VALUES (487, 40.16305294980657, 0.46617653427050265, 0.6129557793065, 65.4766545964787, 0.6280376517713281, 0.5532689568489118, 6, 13, 70.46060180077174, '2025-05-18 07:00:23.258342', '2025-05-18 07:00:23.258342', 489);
INSERT INTO `profile_app_studentrecord` VALUES (486, 44.26930344138505, 0.34564706354989994, 0.48878391234638746, 73.17942651330856, 0.8034373661811897, 0.7845087450238879, 6, 10, 44.951765274714184, '2025-05-18 07:00:23.151343', '2025-05-18 07:00:23.151343', 488);
INSERT INTO `profile_app_studentrecord` VALUES (485, 90.11228097149805, 0.8789443985562042, 0.7969023978690147, 61.412640788188796, 0.6409875963357439, 0.5678917130269047, 5, 14, 51.45059979449412, '2025-05-18 07:00:23.041343', '2025-05-18 07:00:23.041343', 487);
INSERT INTO `profile_app_studentrecord` VALUES (484, 41.191173471933425, 0.45876869053591135, 0.5548068433057587, 67.806508120393, 0.8967861712019872, 0.6246687082729143, 5, 10, 40.72219179842493, '2025-05-18 07:00:22.933343', '2025-05-18 07:00:22.933343', 486);
INSERT INTO `profile_app_studentrecord` VALUES (483, 57.18642503390926, 0.6784419505553174, 0.49485069238245527, 65.4597990095715, 0.6235470432280258, 0.6233882426722641, 4, 14, 57.928248841361196, '2025-05-18 07:00:22.822344', '2025-05-18 07:00:22.822344', 485);
INSERT INTO `profile_app_studentrecord` VALUES (482, 62.71681350141715, 0.6076451048700381, 0.4031540476315429, 51.22683244214918, 0.5552082427783674, 0.3348499937209059, 4, 14, 81.95670674162737, '2025-05-18 07:00:22.714264', '2025-05-18 07:00:22.714264', 484);
INSERT INTO `profile_app_studentrecord` VALUES (481, 75.93234893878812, 0.6833979063887942, 0.7956958383724198, 68.86559658294544, 0.727574548245411, 0.7410175050504256, 6, 14, 71.64706900712746, '2025-05-18 07:00:22.607265', '2025-05-18 07:00:22.607265', 483);
INSERT INTO `profile_app_studentrecord` VALUES (480, 99.42915010884143, 0.9775510036812871, 0.9028267778980579, 66.60902077455098, 0.6783406924611396, 0.7162381570359642, 6, 16, 64.01777528379141, '2025-05-18 07:00:22.493512', '2025-05-18 07:00:22.493512', 482);
INSERT INTO `profile_app_studentrecord` VALUES (479, 100, 1, 1, 78.57826540345981, 0.7366489672240149, 0.8111696264191721, 6, 15, 65.9227244348871, '2025-05-18 07:00:22.387513', '2025-05-18 07:00:22.387513', 481);
INSERT INTO `profile_app_studentrecord` VALUES (478, 90.21172119401061, 0.8979864289266218, 0.9955351097747703, 68.03771553469299, 0.6657899447307054, 0.661591523919631, 8, 16, 53.477108651703276, '2025-05-18 07:00:22.280966', '2025-05-18 07:00:22.280966', 480);
INSERT INTO `profile_app_studentrecord` VALUES (477, 71.63032471224975, 0.7344752854743389, 0.6920230412787425, 73.89152758196995, 0.7146766532152301, 0.7075504148702032, 7, 14, 92.45999329805524, '2025-05-18 07:00:22.174476', '2025-05-18 07:00:22.174476', 479);
INSERT INTO `profile_app_studentrecord` VALUES (476, 69.01944456436229, 0.6335376129659681, 0.7338139966045131, 88.13949518801782, 0.9125654330535451, 0.860491638819743, 7, 16, 60.260649305465705, '2025-05-18 07:00:22.066315', '2025-05-18 07:00:22.066315', 478);
INSERT INTO `profile_app_studentrecord` VALUES (475, 70.55692841556444, 0.6804908982095756, 0.70565886631431, 88.47053206404016, 0.8211090798769842, 0.8879036160057828, 7, 16, 51.090252967121316, '2025-05-18 07:00:21.959224', '2025-05-18 07:00:21.959224', 477);
INSERT INTO `profile_app_studentrecord` VALUES (474, 77.46696678355818, 0.7307267397368079, 0.7367348827615687, 82.57369106052727, 0.7956729464050395, 0.797001596607481, 6, 14, 76.23636897354024, '2025-05-18 07:00:21.848681', '2025-05-18 07:00:21.848681', 476);
INSERT INTO `profile_app_studentrecord` VALUES (473, 58.89837537974122, 0.6275439053581436, 0.5218211276913363, 86.64570523625981, 1, 0.8303339501667493, 8, 14, 55.10091836342416, '2025-05-18 07:00:21.741076', '2025-05-18 07:00:21.741076', 475);
INSERT INTO `profile_app_studentrecord` VALUES (472, 73.22365884482106, 0.7034202528620171, 0.6838338104406333, 78.03133473430988, 0.6892961230774595, 0.7892353266162953, 7, 16, 78.48401497648696, '2025-05-18 07:00:21.630076', '2025-05-18 07:00:21.630076', 474);
INSERT INTO `profile_app_studentrecord` VALUES (471, 82.51970736155927, 0.8442356329228367, 0.7818880109815421, 66.34583011176508, 0.6497270353774849, 0.6637186816949407, 6, 15, 82.22967826290504, '2025-05-18 07:00:21.514077', '2025-05-18 07:00:21.514077', 473);
INSERT INTO `profile_app_studentrecord` VALUES (470, 94.9427820929345, 0.845688230999619, 0.880428301320531, 60.44702926624153, 0.6759737305614543, 0.6467502999243386, 8, 16, 65.47677412181957, '2025-05-18 07:00:21.406078', '2025-05-18 07:00:21.406078', 472);
INSERT INTO `profile_app_studentrecord` VALUES (469, 92.2731469828575, 0.9039741744801253, 0.8692359103182781, 51.45902901838745, 0.6208124798008409, 0.5188233435328804, 7, 15, 85.96639718663135, '2025-05-18 07:00:21.292078', '2025-05-18 07:00:21.292078', 471);
INSERT INTO `profile_app_studentrecord` VALUES (468, 84.49221907074208, 0.83734334451598, 0.8412399413906823, 49.65000223517558, 0.5675750264003766, 0.5280714757478983, 7, 16, 82.39597968248106, '2025-05-18 07:00:21.186079', '2025-05-18 07:00:21.186079', 470);
INSERT INTO `profile_app_studentrecord` VALUES (467, 89.94643372631118, 0.9396323540708402, 0.99543568624977, 66.50785942520538, 0.7054204596033395, 0.5896416434352605, 7, 14, 59.08499711147991, '2025-05-18 07:00:21.080079', '2025-05-18 07:00:21.080079', 469);
INSERT INTO `profile_app_studentrecord` VALUES (466, 100, 0.9956221712710119, 1, 74.75627213736124, 0.8450697096390245, 0.707345713260805, 8, 14, 56.418663224583774, '2025-05-18 07:00:20.972079', '2025-05-18 07:00:20.972079', 468);
INSERT INTO `profile_app_studentrecord` VALUES (465, 81.62816821725394, 0.7835250156890916, 0.8123338399993019, 71.63832669111581, 0.7740220938548446, 0.7416890988132159, 8, 15, 76.63606436058865, '2025-05-18 07:00:20.866080', '2025-05-18 07:00:20.866080', 467);
INSERT INTO `profile_app_studentrecord` VALUES (464, 62.303777811765485, 0.7653834027843962, 0.6510575016640715, 95.46306260429854, 0.8933784525493952, 0.9544849390786411, 6, 14, 45.44306111195178, '2025-05-18 07:00:20.757344', '2025-05-18 07:00:20.757344', 466);
INSERT INTO `profile_app_studentrecord` VALUES (463, 66.9557762653272, 0.6664464888957877, 0.6828478404424767, 87.26706044670662, 0.8663382494012675, 0.9120742078202475, 6, 16, 36.25834418805334, '2025-05-18 07:00:20.650345', '2025-05-18 07:00:20.650345', 465);
INSERT INTO `profile_app_studentrecord` VALUES (462, 59.54460233723913, 0.6543799274164528, 0.5656372642817186, 81.2935348737948, 0.8363364367641205, 0.799866375976402, 6, 15, 100, '2025-05-18 07:00:20.539346', '2025-05-18 07:00:20.539346', 464);
INSERT INTO `profile_app_studentrecord` VALUES (461, 72.72603040682507, 0.718467168483401, 0.6852968645941927, 80.28813971706013, 0.850993615856598, 0.8693917187695703, 8, 14, 100, '2025-05-18 07:00:20.432178', '2025-05-18 07:00:20.432178', 463);
INSERT INTO `profile_app_studentrecord` VALUES (460, 92.31298402110544, 0.8538421982685578, 0.8800866421229792, 64.39798043293622, 0.6139096667616548, 0.7447432221972147, 6, 16, 53.34002516496351, '2025-05-18 07:00:20.324109', '2025-05-18 07:00:20.324109', 462);
INSERT INTO `profile_app_studentrecord` VALUES (459, 69.60441355093029, 0.6963797688693231, 0.835283594345222, 85.30952971647805, 0.809358567202315, 0.7799314392700778, 6, 15, 65.16866076239363, '2025-05-18 07:00:20.200110', '2025-05-18 07:00:20.200110', 461);
INSERT INTO `profile_app_studentrecord` VALUES (458, 100, 0.8884263076254458, 1, 75.22551509959256, 0.7647134117797034, 0.7423434828368108, 7, 14, 60.5360319287982, '2025-05-18 07:00:20.086110', '2025-05-18 07:00:20.086110', 460);
INSERT INTO `profile_app_studentrecord` VALUES (457, 78.91389787579178, 0.7053083417588155, 0.7835755264670766, 76.12963766412992, 0.7781069771802006, 0.7545585604658898, 6, 15, 78.25389894352035, '2025-05-18 07:00:19.978494', '2025-05-18 07:00:19.978494', 459);
INSERT INTO `profile_app_studentrecord` VALUES (456, 84.4043815084825, 0.8367513435032494, 0.8929353804576563, 63.862239212667276, 0.36286388862304425, 0.5550388362985443, 7, 14, 100, '2025-05-18 07:00:19.870495', '2025-05-18 07:00:19.870495', 458);
INSERT INTO `profile_app_studentrecord` VALUES (454, 94.86201127792421, 0.89020225555266, 0.9717537262709399, 79.20023395882191, 0.7126234672614057, 0.7392884240520604, 7, 15, 59.32632663196837, '2025-05-18 07:00:19.659099', '2025-05-18 07:00:19.659099', 456);
INSERT INTO `profile_app_studentrecord` VALUES (453, 60.286499555558066, 0.5659260080088512, 0.4707007117414628, 99.44299249978594, 0.8855992154923282, 0.9808656285876196, 8, 16, 52.29825061125825, '2025-05-18 07:00:19.553099', '2025-05-18 07:00:19.553099', 455);
INSERT INTO `profile_app_studentrecord` VALUES (452, 78.20910746721061, 0.7030025920652107, 0.8309386111603877, 46.34578462748953, 0.5185211634138518, 0.4771962127402325, 8, 15, 87.4669273504877, '2025-05-18 07:00:19.448100', '2025-05-18 07:00:19.448100', 454);
INSERT INTO `profile_app_studentrecord` VALUES (451, 63.66045456622385, 0.5726011414752702, 0.6051403686654317, 83.75808072403942, 0.7975081694711852, 0.8169024409188897, 7, 16, 36.71027353606289, '2025-05-18 07:00:19.342571', '2025-05-18 07:00:19.342571', 453);
INSERT INTO `profile_app_studentrecord` VALUES (450, 82.63561034253681, 0.7948452895243924, 0.7020488818614927, 82.52870423223254, 0.6456372824011783, 0.8161017592867529, 7, 14, 100, '2025-05-18 07:00:19.237031', '2025-05-18 07:00:19.237031', 452);
INSERT INTO `profile_app_studentrecord` VALUES (449, 74.77541511407784, 0.7628607095738948, 0.7550398337539725, 77.61164008160081, 0.6532549856687104, 0.7612674233741356, 8, 15, 69.54626631150474, '2025-05-18 07:00:19.130853', '2025-05-18 07:00:19.130853', 451);
INSERT INTO `profile_app_studentrecord` VALUES (448, 73.21871751441768, 0.731615378305261, 0.7563625844367465, 69.17429250787322, 0.8826913673216058, 0.731272522454335, 6, 15, 85.46181085702223, '2025-05-18 07:00:19.023854', '2025-05-18 07:00:19.023854', 450);
INSERT INTO `profile_app_studentrecord` VALUES (447, 68.70834461646925, 0.6653365297896879, 0.7584530593914472, 92.45898923015116, 0.8688337953773688, 0.9268190194501429, 8, 16, 57.1480053969961, '2025-05-18 07:00:18.915592', '2025-05-18 07:00:18.915592', 449);
INSERT INTO `profile_app_studentrecord` VALUES (446, 76.08110994069493, 0.8061438234465759, 0.737878008692086, 75.2783888684443, 0.7379560843583455, 0.7605275049844223, 8, 15, 65.8344716579853, '2025-05-18 07:00:18.809592', '2025-05-18 07:00:18.809592', 448);
INSERT INTO `profile_app_studentrecord` VALUES (445, 61.799112954070466, 0.5998714627346173, 0.6969633125572915, 83.92501370286982, 0.702873222061746, 0.8342595493794951, 7, 14, 97.48607609865027, '2025-05-18 07:00:18.704593', '2025-05-18 07:00:18.704593', 447);
INSERT INTO `profile_app_studentrecord` VALUES (444, 64.20350087686491, 0.6832307532182849, 0.8095524070992954, 47.17523874104293, 0.44302501565236924, 0.4578486448950771, 7, 15, 90.82099455624844, '2025-05-18 07:00:18.598170', '2025-05-18 07:00:18.598170', 446);
INSERT INTO `profile_app_studentrecord` VALUES (443, 71.7521410616252, 0.702467986841414, 0.7029953519335203, 92.88274509853784, 0.7903446014953804, 0.8613505846263245, 7, 16, 57.988382022141586, '2025-05-18 07:00:18.493456', '2025-05-18 07:00:18.493456', 445);
INSERT INTO `profile_app_studentrecord` VALUES (442, 58.80616674035751, 0.5797210705715027, 0.58324249569147, 84.45921127919924, 0.7329778325397649, 0.9295359949174977, 7, 15, 95.12137561357756, '2025-05-18 07:00:18.375456', '2025-05-18 07:00:18.375456', 444);
INSERT INTO `profile_app_studentrecord` VALUES (441, 86.52064902639441, 0.7611004062294059, 0.8864863077681173, 55.1738446961443, 0.6007260373925933, 0.5832062018934286, 6, 15, 94.9182211233802, '2025-05-18 07:00:18.267847', '2025-05-18 07:00:18.267847', 443);
INSERT INTO `profile_app_studentrecord` VALUES (440, 61.803020755366745, 0.7423543123154742, 0.7311075463658732, 71.6852969927251, 0.7529021305958489, 0.7476401128923464, 8, 16, 66.68464679286166, '2025-05-18 07:00:18.157848', '2025-05-18 07:00:18.157848', 442);
INSERT INTO `profile_app_studentrecord` VALUES (439, 94.0364853089061, 0.8818290687979335, 0.931691315045363, 66.70718796765264, 0.7457786562196022, 0.6793938109225793, 7, 14, 73.62237455662648, '2025-05-18 07:00:18.010301', '2025-05-18 07:00:18.010301', 441);
INSERT INTO `profile_app_studentrecord` VALUES (438, 68.81930120071898, 0.6717407594830521, 0.7051903075194217, 76.58193817547168, 0.7507987407581583, 0.7716331048033358, 6, 15, 99.43643334813741, '2025-05-18 07:00:17.898301', '2025-05-18 07:00:17.898301', 440);
INSERT INTO `profile_app_studentrecord` VALUES (437, 69.45438917060463, 0.7018704145464538, 0.620412119908918, 79.64323741273607, 0.7829710228349152, 0.7501159241047847, 6, 14, 87.7527906222074, '2025-05-18 07:00:17.789302', '2025-05-18 07:00:17.789302', 439);
INSERT INTO `profile_app_studentrecord` VALUES (436, 68.42126085517934, 0.6343221821535686, 0.6426813100021634, 72.04973282779969, 0.7005467746889055, 0.8074113053366322, 8, 15, 100, '2025-05-18 07:00:17.679788', '2025-05-18 07:00:17.679788', 438);
INSERT INTO `profile_app_studentrecord` VALUES (435, 53.89818700226717, 0.6027211876269617, 0.6406215352292897, 95.23805494263152, 0.8889923656391097, 0.9561147890806059, 7, 16, 45.428633191058715, '2025-05-18 07:00:17.573138', '2025-05-18 07:00:17.573138', 437);
INSERT INTO `profile_app_studentrecord` VALUES (434, 48.68249364377999, 0.5752949462465237, 0.6879644965307675, 94.49059269312718, 0.8949223459282064, 0.9193657845018328, 8, 14, 61.02885838086827, '2025-05-18 07:00:17.439139', '2025-05-18 07:00:17.439139', 436);
INSERT INTO `profile_app_studentrecord` VALUES (433, 83.81636241936872, 0.8742919736481666, 0.8419828327400833, 55.896479131372956, 0.4946441110196127, 0.6116984743128684, 7, 14, 85.48680802428346, '2025-05-18 07:00:17.333140', '2025-05-18 07:00:17.333140', 435);
INSERT INTO `profile_app_studentrecord` VALUES (432, 100, 0.9861642549510411, 0.8920264080405892, 64.21461047298759, 0.6973081341977087, 0.6017832572559423, 7, 16, 65.11035945362443, '2025-05-18 07:00:17.218140', '2025-05-18 07:00:17.218140', 434);
INSERT INTO `profile_app_studentrecord` VALUES (431, 96.82769823050158, 0.9829177874482152, 0.999556297192013, 56.79200912408435, 0.5879843814581611, 0.5751583901729026, 9, 19, 100, '2025-05-18 07:00:17.110141', '2025-05-18 07:00:17.110141', 433);
INSERT INTO `profile_app_studentrecord` VALUES (430, 97.39886958693656, 0.9665176384435111, 0.9052207561978992, 58.991981477040696, 0.6834527962184355, 0.5962880234176613, 10, 20, 100, '2025-05-18 07:00:16.997140', '2025-05-18 07:00:16.997140', 432);
INSERT INTO `profile_app_studentrecord` VALUES (429, 80.89926562469645, 0.793389488709149, 0.7728835927391182, 87.60870655017118, 0.9027253333440481, 0.8613050247301081, 9, 20, 100, '2025-05-18 07:00:16.889141', '2025-05-18 07:00:16.889141', 431);
INSERT INTO `profile_app_studentrecord` VALUES (428, 87.90385651859815, 0.8408906910632277, 0.7951003443103972, 83.66427232873849, 0.8330271297056838, 0.7982753329354619, 10, 17, 100, '2025-05-18 07:00:16.777628', '2025-05-18 07:00:16.777628', 430);
INSERT INTO `profile_app_studentrecord` VALUES (427, 100, 1, 1, 77.63155213170806, 0.8409563043168161, 0.8542157278459104, 9, 16, 74.8084940123935, '2025-05-18 07:00:16.633264', '2025-05-18 07:00:16.633264', 429);
INSERT INTO `profile_app_studentrecord` VALUES (426, 85.85688280048049, 0.8454163394614074, 0.7888215083911294, 90.345926127566, 0.9507637833466197, 0.8477728380719219, 8, 20, 100, '2025-05-18 07:00:16.527264', '2025-05-18 07:00:16.527264', 428);
INSERT INTO `profile_app_studentrecord` VALUES (425, 100, 1, 0.9227840189052463, 90.64341511853226, 0.8934377347235128, 0.9160978118803051, 8, 20, 92.6628897428379, '2025-05-18 07:00:16.421265', '2025-05-18 07:00:16.421265', 427);
INSERT INTO `profile_app_studentrecord` VALUES (424, 100, 1, 0.9600655991613756, 80.59560603104222, 0.7994073854527339, 0.8460769440750069, 10, 18, 74.83134989959376, '2025-05-18 07:00:16.314201', '2025-05-18 07:00:16.314201', 426);
INSERT INTO `profile_app_studentrecord` VALUES (423, 97.89538092416018, 1, 0.9570766609451362, 84.9185791148705, 0.8326073382387703, 0.855202368996049, 8, 17, 74.89410384671545, '2025-05-18 07:00:16.189929', '2025-05-18 07:00:16.189929', 425);
INSERT INTO `profile_app_studentrecord` VALUES (422, 91.2144893229941, 0.8927548923627617, 0.9701927526080475, 74.28393516941489, 0.7899744922649546, 0.7361412018827795, 8, 16, 66.66732965789642, '2025-05-18 07:00:16.078930', '2025-05-18 07:00:16.078930', 424);
INSERT INTO `profile_app_studentrecord` VALUES (421, 99.70577006515735, 1, 0.9371962198329733, 80.16010070958234, 0.7748011294145855, 0.7741882280983238, 10, 17, 71.16325532438998, '2025-05-18 07:00:15.970930', '2025-05-18 07:00:15.970930', 423);
INSERT INTO `profile_app_studentrecord` VALUES (420, 66.43608612931959, 0.6392067157765117, 0.5369298128245744, 100, 1, 1, 10, 17, 65.0443672765093, '2025-05-18 07:00:15.862931', '2025-05-18 07:00:15.862931', 422);
INSERT INTO `profile_app_studentrecord` VALUES (419, 100, 1, 1, 69.38803625542309, 0.614706674524404, 0.6475302542621754, 10, 18, 99.94761285022304, '2025-05-18 07:00:15.753932', '2025-05-18 07:00:15.753932', 421);
INSERT INTO `profile_app_studentrecord` VALUES (418, 82.0598040069433, 0.7794820284390382, 0.8475961197942101, 85.61018143847328, 0.9394672645087033, 0.8795898181478503, 8, 20, 100, '2025-05-18 07:00:15.647932', '2025-05-18 07:00:15.647932', 420);
INSERT INTO `profile_app_studentrecord` VALUES (417, 98.79677033802825, 0.9918798547571486, 0.9655362010451727, 83.1921619675733, 0.8866006304029779, 0.8061450872825887, 10, 17, 76.8817802009988, '2025-05-18 07:00:15.541418', '2025-05-18 07:00:15.541418', 419);
INSERT INTO `profile_app_studentrecord` VALUES (416, 100, 1, 0.9239468050799919, 79.16279021241208, 0.7532913365327434, 0.8507743913196874, 8, 19, 65.3971482652133, '2025-05-18 07:00:15.415884', '2025-05-18 07:00:15.415884', 418);
INSERT INTO `profile_app_studentrecord` VALUES (415, 92.8944651513839, 0.986287242298906, 1, 83.94430593008863, 0.8016118381750155, 0.8819415815217014, 8, 19, 74.87426611095599, '2025-05-18 07:00:15.308817', '2025-05-18 07:00:15.308817', 417);
INSERT INTO `profile_app_studentrecord` VALUES (414, 97.89693125306803, 0.9542248338570584, 0.9452297189825265, 79.02349966583493, 0.7461214801391527, 0.817672406508661, 8, 17, 72.00480379393836, '2025-05-18 07:00:15.201818', '2025-05-18 07:00:15.201818', 416);
INSERT INTO `profile_app_studentrecord` VALUES (413, 100, 1, 1, 52.68104482958098, 0.6319853046194173, 0.6649753270492614, 9, 17, 100, '2025-05-18 07:00:15.095731', '2025-05-18 07:00:15.095731', 415);
INSERT INTO `profile_app_studentrecord` VALUES (412, 63.76614552227821, 0.6228833605195101, 0.6493429492424845, 100, 1, 0.9835968005441006, 10, 19, 58.73437167479036, '2025-05-18 07:00:14.962735', '2025-05-18 07:00:14.962735', 414);
INSERT INTO `profile_app_studentrecord` VALUES (411, 83.4294432136026, 0.7532925141984432, 0.7850703706471437, 100, 0.9499697124727959, 1, 8, 16, 59.28869890963763, '2025-05-18 07:00:14.857736', '2025-05-18 07:00:14.857736', 413);
INSERT INTO `profile_app_studentrecord` VALUES (410, 100, 1, 1, 65.96879508218434, 0.5723068906094061, 0.5948763832317845, 10, 20, 100, '2025-05-18 07:00:14.751574', '2025-05-18 07:00:14.751574', 412);
INSERT INTO `profile_app_studentrecord` VALUES (409, 100, 0.9424451933080242, 0.9161593216830818, 62.99680588729947, 0.6624038617227707, 0.6039642607530066, 10, 19, 93.94630693832983, '2025-05-18 07:00:14.645575', '2025-05-18 07:00:14.645575', 411);
INSERT INTO `profile_app_studentrecord` VALUES (408, 84.18737066512499, 0.8400532852951149, 0.8297990402463508, 89.51887253366934, 0.9820221988857216, 0.8986878471877009, 9, 20, 99.18007090768556, '2025-05-18 07:00:14.539484', '2025-05-18 07:00:14.539484', 410);
INSERT INTO `profile_app_studentrecord` VALUES (407, 89.28341206311184, 0.9281268308417423, 0.8795707775375052, 93.71664288404862, 0.8943886222772904, 0.9565271054103952, 8, 18, 91.7029208053904, '2025-05-18 07:00:14.433484', '2025-05-18 07:00:14.433484', 409);
INSERT INTO `profile_app_studentrecord` VALUES (406, 100, 1, 1, 78.71521716629924, 0.8243608776579808, 0.8169825078086714, 9, 19, 74.59727037726455, '2025-05-18 07:00:14.320485', '2025-05-18 07:00:14.320485', 408);
INSERT INTO `profile_app_studentrecord` VALUES (405, 92.82562585186274, 0.9119876645084223, 0.93480595848119, 91.30120595596107, 0.888266030232441, 0.9071762841889205, 9, 19, 84.3078911909544, '2025-05-18 07:00:14.213392', '2025-05-18 07:00:14.213392', 407);
INSERT INTO `profile_app_studentrecord` VALUES (404, 90.40669682518205, 0.8798589718202672, 0.9307161070573841, 84.19044702480728, 0.9214854793523926, 0.8843218745700283, 9, 16, 96.72227783641753, '2025-05-18 07:00:14.106790', '2025-05-18 07:00:14.106790', 406);
INSERT INTO `profile_app_studentrecord` VALUES (403, 94.83112384267724, 0.9503038748551614, 0.943184948670755, 66.46956333634526, 0.6830791972284789, 0.6818334289337851, 10, 20, 95.75388663531704, '2025-05-18 07:00:13.998252', '2025-05-18 07:00:13.998252', 405);
INSERT INTO `profile_app_studentrecord` VALUES (402, 100, 0.9848190465840286, 0.9458681668399153, 86.52731423671548, 0.8677343521393408, 0.7344531282733758, 8, 18, 67.44183935867913, '2025-05-18 07:00:13.892763', '2025-05-18 07:00:13.892763', 404);
INSERT INTO `profile_app_studentrecord` VALUES (599, 24.14398571149416, 0.19948189185850346, 0.33559757049839706, 20.70517502586446, 0.315820609778787, 0.26293606415696813, 0, 2, 23.771631639987888, '2025-05-18 07:00:35.567772', '2025-05-18 07:00:35.567772', 601);
INSERT INTO `profile_app_studentrecord` VALUES (598, 30.695633697976927, 0.25087889478997183, 0.20337687868998292, 39.48319811008005, 0.40693535398237934, 0.3509059619472232, 1, 2, 24.110697717411984, '2025-05-18 07:00:35.442746', '2025-05-18 07:00:35.442746', 600);
INSERT INTO `profile_app_studentrecord` VALUES (597, 25.57927219142083, 0.22175247060862316, 0.12317684395649513, 43.15819414043745, 0.39796003452046563, 0.3449645394024287, 0, 0, 39.176080956836046, '2025-05-18 07:00:35.334723', '2025-05-18 07:00:35.334723', 599);
INSERT INTO `profile_app_studentrecord` VALUES (596, 29.131560438231546, 0.33004238145788006, 0.44827618267946806, 18.096903829254273, 0.1541774739400163, 0.2067865732007957, 2, 3, 38.644485445800505, '2025-05-18 07:00:35.212567', '2025-05-18 07:00:35.212567', 598);
INSERT INTO `profile_app_studentrecord` VALUES (595, 48.95703176998365, 0.38035673599581427, 0.4712165075741932, 24.45464358202889, 0.2210281748028113, 0.3019566173967842, 2, 4, 30.801948544767985, '2025-05-18 07:00:35.099264', '2025-05-18 07:00:35.099264', 597);
INSERT INTO `profile_app_studentrecord` VALUES (608, 90, 0.95, 0.9, 99, 0.95, 0.95, 10, 20, 90, '2025-05-19 06:11:07.981540', '2025-05-19 06:11:07.981540', 611);
INSERT INTO `profile_app_studentrecord` VALUES (593, 39.62218042159702, 0.4602838028823797, 0.32678235837363334, 23.594285584725156, 0.31554691946177116, 0.293129482142209, 2, 5, 26.92846234523597, '2025-05-18 07:00:34.862873', '2025-05-18 07:00:34.862873', 595);
INSERT INTO `profile_app_studentrecord` VALUES (592, 26.555688509961904, 0.22132284967199697, 0.3132597287694594, 29.834010396801247, 0.20260281004090025, 0.40321449495231687, 0, 1, 36.20834013943263, '2025-05-18 07:00:34.744489', '2025-05-18 07:00:34.744489', 594);
INSERT INTO `profile_app_studentrecord` VALUES (591, 31.76114797811581, 0.4214382973970441, 0.27772454534000773, 30.294029777548754, 0.18547118797839737, 0.24474112395959347, 2, 3, 31.74532382439103, '2025-05-18 07:00:34.610200', '2025-05-18 07:00:34.610200', 593);
INSERT INTO `profile_app_studentrecord` VALUES (590, 24.709852012503024, 0.2724766208439688, 0.31446536732309843, 28.786693119492256, 0.2184910274649704, 0.2743042043129508, 2, 4, 42.993631242939735, '2025-05-18 07:00:34.484078', '2025-05-18 07:00:34.484078', 592);
INSERT INTO `profile_app_studentrecord` VALUES (589, 33.985972959469066, 0.3076947903510051, 0.3021881230760094, 39.82415770105682, 0.3235830275162406, 0.3585360119188488, 2, 6, 38.73989948012104, '2025-05-18 07:00:34.372906', '2025-05-18 07:00:34.372906', 591);
INSERT INTO `profile_app_studentrecord` VALUES (588, 37.0535713356476, 0.4176370271927602, 0.35617123393855704, 24.587417071819303, 0.2764569302586197, 0.1892470302574566, 0, 6, 43.78672173509299, '2025-05-18 07:00:34.264194', '2025-05-18 07:00:34.264194', 590);
INSERT INTO `profile_app_studentrecord` VALUES (587, 22.43202947444378, 0.2551232881416281, 0.29259907482346714, 29.7119537696116, 0.406642610654539, 0.32084181908940423, 2, 6, 19.17026299176396, '2025-05-18 07:00:34.154746', '2025-05-18 07:00:34.154746', 589);
INSERT INTO `profile_app_studentrecord` VALUES (609, 12, 0.5, 0.32, 23, 0.12, 0.3, 3, 5, 32, '2025-05-19 06:11:53.446692', '2025-05-19 06:11:53.446692', 603);
INSERT INTO `profile_app_studentrecord` VALUES (585, 31.36128592673556, 0.29891253002420803, 0.4280426326323065, 22.31234279076146, 0.3225017406734844, 0.34981363298943186, 1, 1, 23.65830339863221, '2025-05-18 07:00:33.920724', '2025-05-18 07:00:33.920724', 587);
INSERT INTO `profile_app_studentrecord` VALUES (584, 17.80888026244824, 0.2035077443480599, 0.19029238204669588, 22.43688761872714, 0.2795800564391701, 0.232557180940658, 0, 3, 26.876042236917897, '2025-05-18 07:00:33.814724', '2025-05-18 07:00:33.814724', 586);
INSERT INTO `profile_app_studentrecord` VALUES (583, 29.286073084217417, 0.2878028571228383, 0.17636507224190232, 28.174995217266726, 0.33543869424682493, 0.2963112854346225, 0, 0, 44.935515783383934, '2025-05-18 07:00:33.708131', '2025-05-18 07:00:33.708131', 585);
INSERT INTO `profile_app_studentrecord` VALUES (582, 32.73511856395755, 0.3056907079699631, 0.27348575903473143, 30.239472520484693, 0.2888376674594108, 0.32449425650247576, 0, 5, 37.18927791103896, '2025-05-18 07:00:33.602132', '2025-05-18 07:00:33.602132', 584);
INSERT INTO `profile_app_studentrecord` VALUES (581, 46.507931099796515, 0.4758854704309165, 0.502273707195082, 20.638952256372825, 0.33626252442411086, 0.219901058082864, 3, 10, 39.02452487025188, '2025-05-18 07:00:33.496132', '2025-05-18 07:00:33.496132', 583);
INSERT INTO `profile_app_studentrecord` VALUES (580, 31.195666181345928, 0.35461078838306137, 0.5212517093753497, 46.07019773720972, 0.3825801467828422, 0.466690186218736, 3, 10, 64.64434000360625, '2025-05-18 07:00:33.390132', '2025-05-18 07:00:33.390132', 582);
INSERT INTO `profile_app_studentrecord` VALUES (579, 32.29647382254567, 0.3052295800084287, 0.41713339034423597, 62.9517798721256, 0.6755208878129438, 0.640012051026059, 4, 7, 29.346384534919196, '2025-05-18 07:00:33.284136', '2025-05-18 07:00:33.284136', 581);
INSERT INTO `profile_app_studentrecord` VALUES (578, 30.480171936675667, 0.2755090492729436, 0.3425194099437885, 47.56528978469078, 0.46004831817279135, 0.47092503687733334, 2, 10, 67.61033577310143, '2025-05-18 07:00:33.177894', '2025-05-18 07:00:33.177894', 580);
INSERT INTO `profile_app_studentrecord` VALUES (577, 29.835096326968156, 0.3418394969373251, 0.34443705527671653, 53.70519100091339, 0.4773191778154434, 0.5878300137053301, 2, 8, 26.021736262208226, '2025-05-18 07:00:33.071507', '2025-05-18 07:00:33.071507', 579);
INSERT INTO `profile_app_studentrecord` VALUES (576, 59.724186504009516, 0.6942551860355235, 0.5257556069072126, 27.270033432452678, 0.28049346936973824, 0.29846234677422945, 4, 10, 41.320941394631, '2025-05-18 07:00:32.965827', '2025-05-18 07:00:32.965827', 578);
INSERT INTO `profile_app_studentrecord` VALUES (575, 48.26324131689265, 0.39571620884995395, 0.5423023550269359, 39.41569950557523, 0.1639702386516812, 0.2680770698775414, 3, 6, 46.928407483488556, '2025-05-18 07:00:32.860323', '2025-05-18 07:00:32.860323', 577);
INSERT INTO `profile_app_studentrecord` VALUES (574, 53.655559388046576, 0.5657880978172516, 0.5747648159320398, 42.38422231877985, 0.39375495096788193, 0.3594009109413501, 2, 7, 46.3180746271555, '2025-05-18 07:00:32.751082', '2025-05-18 07:00:32.751082', 576);
INSERT INTO `profile_app_studentrecord` VALUES (573, 60.65983414501325, 0.5667641696418247, 0.5123664286876218, 25.097388095766448, 0.4413559660862122, 0.31712214794108873, 4, 8, 41.22748647769949, '2025-05-18 07:00:32.641223', '2025-05-18 07:00:32.641223', 575);
INSERT INTO `profile_app_studentrecord` VALUES (572, 32.62380162428441, 0.39390955839970326, 0.44358138271287545, 36.3456600929726, 0.33411620747171455, 0.527834919358118, 4, 6, 61.376768248636495, '2025-05-18 07:00:32.526079', '2025-05-18 07:00:32.526079', 574);
INSERT INTO `profile_app_studentrecord` VALUES (571, 49.7391978045398, 0.4407873680182402, 0.5061388692433441, 50.845744496894824, 0.4872348134908918, 0.5011352425423997, 3, 6, 29.716772599886067, '2025-05-18 07:00:32.419360', '2025-05-18 07:00:32.419360', 573);
INSERT INTO `profile_app_studentrecord` VALUES (570, 67.45906262876849, 0.6253426491770734, 0.6006623803148243, 16.187129101767102, 0.4335627283948707, 0.23351011887263648, 4, 9, 40.461859283252494, '2025-05-18 07:00:32.311969', '2025-05-18 07:00:32.311969', 572);
INSERT INTO `profile_app_studentrecord` VALUES (569, 56.14073438103666, 0.48041602693267554, 0.46920790312728533, 41.01275473763088, 0.39018181988765205, 0.33765055645829817, 2, 10, 54.127518948080045, '2025-05-18 07:00:32.205979', '2025-05-18 07:00:32.205979', 571);
INSERT INTO `profile_app_studentrecord` VALUES (568, 65.60858115806398, 0.6690432380886616, 0.6451672116159918, 40.04985992451863, 0.41124736962647146, 0.39613874962801077, 3, 10, 28.61468077382442, '2025-05-18 07:00:32.096195', '2025-05-18 07:00:32.096195', 570);
INSERT INTO `profile_app_studentrecord` VALUES (567, 63.84956646103402, 0.6519245622195315, 0.4957562745613868, 33.18677994131219, 0.2726866698960012, 0.2935284552688276, 2, 7, 30.987362010453126, '2025-05-18 07:00:31.980886', '2025-05-18 07:00:31.980886', 569);
INSERT INTO `profile_app_studentrecord` VALUES (566, 67.44216804462107, 0.5460818642431013, 0.4633322026950693, 51.07231708383053, 0.5613014294681311, 0.5049063554574214, 4, 6, 40.75116283139066, '2025-05-18 07:00:31.874887', '2025-05-18 07:00:31.874887', 568);
INSERT INTO `profile_app_studentrecord` VALUES (565, 41.33532204702742, 0.41481207101491185, 0.4151295065175754, 35.9793210140179, 0.36290053925534865, 0.3844337343365916, 3, 7, 30.747329751610984, '2025-05-18 07:00:31.768287', '2025-05-18 07:00:31.768287', 567);
INSERT INTO `profile_app_studentrecord` VALUES (564, 38.164155397195124, 0.38241665719594825, 0.43694692690980147, 44.42543136650797, 0.41337754383370745, 0.3514110802907347, 2, 7, 54.78864785803035, '2025-05-18 07:00:31.661418', '2025-05-18 07:00:31.661418', 566);
INSERT INTO `profile_app_studentrecord` VALUES (563, 46.94417180397325, 0.48425428083165145, 0.5266228684091436, 40.456698164586726, 0.5110659637523198, 0.3810295279833181, 3, 8, 41.66896271395411, '2025-05-18 07:00:31.555419', '2025-05-18 07:00:31.555419', 565);
INSERT INTO `profile_app_studentrecord` VALUES (562, 32.54036871446278, 0.37044012550720046, 0.3734715711593829, 63.77187866703327, 0.46119949757980083, 0.6067516628024171, 4, 9, 24.209722544834655, '2025-05-18 07:00:31.446776', '2025-05-18 07:00:31.446776', 564);
INSERT INTO `profile_app_studentrecord` VALUES (561, 72.5816691600909, 0.5836738289168225, 0.6201303849041377, 45.43635538035645, 0.42339178246693826, 0.36338238006013895, 3, 9, 42.05179227340028, '2025-05-18 07:00:31.313235', '2025-05-18 07:00:31.313235', 563);
INSERT INTO `profile_app_studentrecord` VALUES (560, 48.38989340222008, 0.43079301896823763, 0.41203245217016105, 43.9812159745034, 0.4466553789706071, 0.48206473085342716, 2, 7, 43.79225409814163, '2025-05-18 07:00:31.207236', '2025-05-18 07:00:31.207236', 562);
INSERT INTO `profile_app_studentrecord` VALUES (559, 45.39482824847508, 0.46200572706775006, 0.45880077113869455, 34.21716998057491, 0.3387411875440807, 0.2993884198656537, 3, 6, 68.97134561194672, '2025-05-18 07:00:31.101237', '2025-05-18 07:00:31.101237', 561);
INSERT INTO `profile_app_studentrecord` VALUES (558, 44.91944644342328, 0.5038987816920841, 0.5037712986894987, 26.93128468405596, 0.4448460584170715, 0.2789375741300227, 2, 6, 57.9853691349924, '2025-05-18 07:00:30.995238', '2025-05-18 07:00:30.995238', 560);
INSERT INTO `profile_app_studentrecord` VALUES (557, 66.2542077059915, 0.6036187111386286, 0.5463118468301313, 43.32081671642294, 0.29560003341125674, 0.37263240784927343, 3, 10, 35.03709401161954, '2025-05-18 07:00:30.867238', '2025-05-18 07:00:30.867238', 559);
INSERT INTO `profile_app_studentrecord` VALUES (556, 53.97439131240162, 0.5996165219233371, 0.6530685754497856, 31.55108925752844, 0.3526187795799494, 0.3147932137815989, 3, 9, 35.22382897375845, '2025-05-18 07:00:30.760238', '2025-05-18 07:00:30.760238', 558);
INSERT INTO `profile_app_studentrecord` VALUES (555, 21.7131172042224, 0.2614723179401696, 0.3203006131279073, 67.3807999789359, 0.4977574869934638, 0.6935510414870093, 2, 8, 26.520615899446014, '2025-05-18 07:00:30.653724', '2025-05-18 07:00:30.654725', 557);
INSERT INTO `profile_app_studentrecord` VALUES (554, 39.66179089445013, 0.3988722913817388, 0.3010599721443766, 57.483186462635224, 0.3989542339620374, 0.5469325866085951, 2, 10, 29.296903358992225, '2025-05-18 07:00:30.543769', '2025-05-18 07:00:30.543769', 556);
INSERT INTO `profile_app_studentrecord` VALUES (553, 53.58576439351076, 0.5751337796995252, 0.5252908976160001, 34.50214483727985, 0.340634356290765, 0.22357199498603844, 3, 7, 66.62317880978136, '2025-05-18 07:00:30.432770', '2025-05-18 07:00:30.432770', 555);
INSERT INTO `profile_app_studentrecord` VALUES (552, 55.86083880412964, 0.6025493340446078, 0.5383112286744515, 33.95777296430607, 0.17713892194028155, 0.29751677219314226, 3, 6, 60.09516229436268, '2025-05-18 07:00:30.327177', '2025-05-18 07:00:30.327177', 554);
INSERT INTO `profile_app_studentrecord` VALUES (551, 59.79725476751246, 0.5711878577756166, 0.5313390473853871, 61.57876058309521, 0.5174750246574902, 0.5179759560543481, 5, 11, 62.32501224677647, '2025-05-18 07:00:30.221299', '2025-05-18 07:00:30.221299', 553);
INSERT INTO `profile_app_studentrecord` VALUES (550, 48.91153303908908, 0.45694302618628463, 0.5772796333622955, 62.72971257674814, 0.6729018786870704, 0.6954288352774887, 6, 11, 87.2149822801177, '2025-05-18 07:00:30.115299', '2025-05-18 07:00:30.115299', 552);
INSERT INTO `profile_app_studentrecord` VALUES (549, 79.88179107579151, 0.800478156160596, 0.6125671146105014, 63.68584083968533, 0.5729822936830049, 0.5727761632746703, 6, 10, 67.83627799124014, '2025-05-18 07:00:30.008300', '2025-05-18 07:00:30.008300', 551);
INSERT INTO `profile_app_studentrecord` VALUES (548, 53.737461248447595, 0.46402331574896544, 0.5061603228000627, 56.810199584078745, 0.5664542712949003, 0.5824859118739768, 4, 13, 87.35764025953759, '2025-05-18 07:00:29.903300', '2025-05-18 07:00:29.903300', 550);
INSERT INTO `profile_app_studentrecord` VALUES (547, 49.14712623929778, 0.5597080582150227, 0.6769053736838867, 66.21337330750757, 0.8215608586696225, 0.6719114880131903, 6, 13, 37.802722320136596, '2025-05-18 07:00:29.796301', '2025-05-18 07:00:29.796301', 549);
INSERT INTO `profile_app_studentrecord` VALUES (546, 86.897552180531, 0.8001980765905269, 0.8220170353357917, 51.022065306559725, 0.4939655914760312, 0.47964199705315075, 6, 11, 27.416056277343845, '2025-05-18 07:00:29.686302', '2025-05-18 07:00:29.686302', 548);
INSERT INTO `profile_app_studentrecord` VALUES (545, 70.3310973614642, 0.7190184528062572, 0.5128107082433617, 24.706613701803246, 0.5385452707690962, 0.31007324955616744, 5, 14, 75.67939122443302, '2025-05-18 07:00:29.579302', '2025-05-18 07:00:29.579302', 547);
INSERT INTO `profile_app_studentrecord` VALUES (544, 71.50760049457276, 0.6067322343742753, 0.6942524841515862, 49.10047370535464, 0.5529463736342071, 0.5956765305224048, 6, 14, 70.49497573000876, '2025-05-18 07:00:29.473302', '2025-05-18 07:00:29.473302', 546);
INSERT INTO `profile_app_studentrecord` VALUES (543, 53.05238642194948, 0.5247156206032095, 0.7728967742531152, 56.530569797714776, 0.5154905562469946, 0.6025241155045823, 4, 11, 43.26474352360545, '2025-05-18 07:00:29.365776', '2025-05-18 07:00:29.365776', 545);
INSERT INTO `profile_app_studentrecord` VALUES (542, 46.27561524587874, 0.4707019950846818, 0.5163509503906348, 83.42460763567924, 0.6475540653341818, 0.8581597249976021, 6, 12, 50.91309320594121, '2025-05-18 07:00:29.258210', '2025-05-18 07:00:29.258210', 544);
INSERT INTO `profile_app_studentrecord` VALUES (541, 42.89273138462059, 0.37798402419189925, 0.3648333974574587, 52.5017610020132, 0.7637582815000098, 0.5624651521689057, 5, 13, 63.84283663352643, '2025-05-18 07:00:29.146792', '2025-05-18 07:00:29.146792', 543);
INSERT INTO `profile_app_studentrecord` VALUES (540, 42.27918303704751, 0.3721135876547744, 0.6404137268395762, 59.72800653886666, 0.545353299859268, 0.5917854682946075, 4, 12, 76.08356329354471, '2025-05-18 07:00:29.025809', '2025-05-18 07:00:29.025809', 542);
INSERT INTO `profile_app_studentrecord` VALUES (539, 68.19374363950188, 0.8265202207203423, 0.5285014990119983, 65.9439278128326, 0.769954351647677, 0.6105513782212862, 4, 14, 27.23032189266165, '2025-05-18 07:00:28.908193', '2025-05-18 07:00:28.908193', 541);
INSERT INTO `profile_app_studentrecord` VALUES (538, 60.809245447706445, 0.7104356085220006, 0.5635610844416462, 59.82753290245649, 0.5992693774659595, 0.6253511499918175, 4, 11, 40.33410624911215, '2025-05-18 07:00:28.802655', '2025-05-18 07:00:28.802655', 540);
INSERT INTO `profile_app_studentrecord` VALUES (537, 71.4960604928637, 0.7528422291316936, 0.8767289782564316, 41.92452043564148, 0.39168767169544905, 0.4600617760710362, 6, 11, 48.35942576073242, '2025-05-18 07:00:28.697595', '2025-05-18 07:00:28.697595', 539);
INSERT INTO `profile_app_studentrecord` VALUES (536, 64.90539237772981, 0.5928973495587866, 0.6770831212863783, 73.17112342247805, 0.5331801491720529, 0.7159855838032897, 4, 13, 75.68694712117514, '2025-05-18 07:00:28.591759', '2025-05-18 07:00:28.591759', 538);
INSERT INTO `profile_app_studentrecord` VALUES (535, 74.98207584937265, 0.576020755861252, 0.7371681886683588, 58.887887401181644, 0.3662826615201098, 0.46964355972250266, 5, 12, 70.62926245601003, '2025-05-18 07:00:28.483758', '2025-05-18 07:00:28.483758', 537);
INSERT INTO `profile_app_studentrecord` VALUES (534, 57.51017865455325, 0.5982901579631675, 0.7252810715895454, 51.896260350671184, 0.6696418114191566, 0.5755889116566357, 4, 13, 88.98005011064089, '2025-05-18 07:00:28.373244', '2025-05-18 07:00:28.373244', 536);
INSERT INTO `profile_app_studentrecord` VALUES (533, 56.2889663705229, 0.6676751572266295, 0.7016092788568967, 50.95633099470847, 0.396717269965028, 0.39597589190558824, 4, 11, 67.84833404148343, '2025-05-18 07:00:28.267588', '2025-05-18 07:00:28.267588', 535);
INSERT INTO `profile_app_studentrecord` VALUES (532, 47.58480167096872, 0.45939922761467605, 0.7420918537776141, 63.511074520672764, 0.33653750358810103, 0.31716607715971734, 5, 10, 69.04321806092857, '2025-05-18 07:00:28.160589', '2025-05-18 07:00:28.160589', 534);
INSERT INTO `profile_app_studentrecord` VALUES (531, 54.48113590453215, 0.5158043817615235, 0.6133779827004744, 34.86871202070519, 0.6615873778091468, 0.5290770986978865, 6, 10, 68.12683214921324, '2025-05-18 07:00:28.054293', '2025-05-18 07:00:28.054293', 533);
INSERT INTO `profile_app_studentrecord` VALUES (530, 83.30553938111503, 0.7196303897088925, 0.8011963517695463, 30.174150834534547, 0.5498474782289212, 0.3964056677797394, 4, 11, 62.946280690919295, '2025-05-18 07:00:27.947589', '2025-05-18 07:00:27.947589', 532);
INSERT INTO `profile_app_studentrecord` VALUES (529, 85.38829925211458, 0.8588065792540494, 0.8034089344505305, 73.01279485034935, 0.3918687119062727, 0.6483926403519779, 4, 12, 57.46840273990637, '2025-05-18 07:00:27.841507', '2025-05-18 07:00:27.841507', 531);
INSERT INTO `profile_app_studentrecord` VALUES (528, 54.83213049038088, 0.5729405517112958, 0.6902113145049341, 50.140283631068826, 0.46893793837091513, 0.5501158836631265, 4, 10, 69.4811048902561, '2025-05-18 07:00:27.734506', '2025-05-18 07:00:27.734506', 530);
INSERT INTO `profile_app_studentrecord` VALUES (527, 78.2516478710246, 0.7738877683841305, 0.709862029327835, 62.76341182140062, 0.6655447338430244, 0.5502195935312375, 4, 12, 63.03126312203066, '2025-05-18 07:00:27.627507', '2025-05-18 07:00:27.627507', 529);
INSERT INTO `profile_app_studentrecord` VALUES (526, 76.20337344363381, 0.7680779830132058, 0.7135629478405023, 43.05196941219526, 0.47614165829555033, 0.4419253154970748, 5, 11, 72.91775566611415, '2025-05-18 07:00:27.514309', '2025-05-18 07:00:27.514309', 528);
INSERT INTO `profile_app_studentrecord` VALUES (525, 60.52700100943381, 0.6446970158669942, 0.47630963239408347, 37.249423358538664, 0.44747923301525, 0.45373727083844445, 6, 11, 71.6784235591663, '2025-05-18 07:00:27.407464', '2025-05-18 07:00:27.407464', 527);
INSERT INTO `profile_app_studentrecord` VALUES (524, 25.696907669973857, 0.36254608933642635, 0.44334110359504814, 66.80792726017063, 0.8022228175512803, 0.5965673119204995, 4, 12, 11.250208916771339, '2025-05-18 07:00:27.298385', '2025-05-18 07:00:27.298385', 526);
INSERT INTO `profile_app_studentrecord` VALUES (523, 63.1808747200019, 0.6060044541479351, 0.6388397894605764, 72.98612826667504, 0.841651498910961, 0.6857193415640959, 4, 10, 84.3363595495824, '2025-05-18 07:00:27.184469', '2025-05-18 07:00:27.184469', 525);
INSERT INTO `profile_app_studentrecord` VALUES (522, 50.15827355188929, 0.607193187623194, 0.5643212261385788, 35.85238559954797, 0.3221701758446534, 0.37342133263414057, 4, 14, 53.53153122501542, '2025-05-18 07:00:27.077432', '2025-05-18 07:00:27.077432', 524);
INSERT INTO `profile_app_studentrecord` VALUES (521, 81.03905509341837, 0.626198056964984, 0.888708260529038, 55.42548419723017, 0.3926530587180133, 0.673570922884334, 5, 14, 47.90537956599332, '2025-05-18 07:00:26.971433', '2025-05-18 07:00:26.971433', 523);
INSERT INTO `profile_app_studentrecord` VALUES (520, 49.923417206649276, 0.5962617463856134, 0.5268469547274063, 69.98036163388333, 0.6463633611854206, 0.6280909708839624, 5, 10, 95.04853950670483, '2025-05-18 07:00:26.865433', '2025-05-18 07:00:26.865433', 522);
INSERT INTO `profile_app_studentrecord` VALUES (519, 63.14280768018472, 0.6737832136228221, 0.5077481111011083, 62.336963114927336, 0.48153403674956974, 0.5583794184530742, 5, 11, 51.160915621214365, '2025-05-18 07:00:26.758433', '2025-05-18 07:00:26.758433', 521);
INSERT INTO `profile_app_studentrecord` VALUES (518, 54.919414861927024, 0.6391380707844204, 0.5143272365158276, 59.96069840467491, 0.5717911922042975, 0.5167375356317085, 6, 14, 74.53027358653759, '2025-05-18 07:00:26.652434', '2025-05-18 07:00:26.652434', 520);
INSERT INTO `profile_app_studentrecord` VALUES (517, 77.00706057752244, 0.729734086227975, 0.7477595629347866, 35.876414376855884, 0.4662027327247767, 0.2468105365597572, 5, 11, 29.3953971530319, '2025-05-18 07:00:26.546435', '2025-05-18 07:00:26.546435', 519);
INSERT INTO `profile_app_studentrecord` VALUES (516, 78.41979953444903, 0.7288096546348015, 0.7879070481826971, 49.67145154844137, 0.518807261009248, 0.5142219480039631, 4, 11, 48.335514278193834, '2025-05-18 07:00:26.440436', '2025-05-18 07:00:26.440436', 518);
INSERT INTO `profile_app_studentrecord` VALUES (515, 77.94736755091648, 0.5481070056083563, 0.8210448936662845, 62.93877607774236, 0.5360667249598002, 0.5335115911252427, 4, 12, 44.125319410640984, '2025-05-18 07:00:26.335356', '2025-05-18 07:00:26.335356', 517);
INSERT INTO `profile_app_studentrecord` VALUES (514, 68.59261152164686, 0.658279176585266, 0.6824826324095332, 53.07986940994935, 0.41658882207409353, 0.46774030180260445, 6, 10, 39.111907827876585, '2025-05-18 07:00:26.219357', '2025-05-18 07:00:26.219357', 516);
INSERT INTO `profile_app_studentrecord` VALUES (513, 59.38713897945946, 0.7068356315235986, 0.8063153311702578, 67.78237106397461, 0.6610190301498926, 0.710346176339867, 5, 14, 43.32926562309045, '2025-05-18 07:00:26.106355', '2025-05-18 07:00:26.106355', 515);
INSERT INTO `profile_app_studentrecord` VALUES (512, 53.75970343568143, 0.6148717344378634, 0.6305098447550983, 56.30948840687225, 0.4546011256135097, 0.4288912773521379, 5, 14, 72.46108533453865, '2025-05-18 07:00:25.998355', '2025-05-18 07:00:25.998355', 514);
INSERT INTO `profile_app_studentrecord` VALUES (511, 67.84735173568396, 0.6802196564153553, 0.740095580883998, 49.75375832892942, 0.5491476021939906, 0.5753033197357185, 6, 13, 55.81203997922921, '2025-05-18 07:00:25.882356', '2025-05-18 07:00:25.882356', 513);
INSERT INTO `profile_app_studentrecord` VALUES (510, 93.89147364454557, 0.9401134450999062, 1, 59.14509031357656, 0.5752993741412283, 0.6334472948698276, 6, 12, 25.765110940658207, '2025-05-18 07:00:25.776841', '2025-05-18 07:00:25.776841', 512);
INSERT INTO `profile_app_studentrecord` VALUES (509, 57.97366765613957, 0.6514084339473811, 0.6860466372294357, 31.67262188772971, 0.3807238881420919, 0.3925444626639589, 4, 10, 75.96168428776049, '2025-05-18 07:00:25.670291', '2025-05-18 07:00:25.670291', 511);
INSERT INTO `profile_app_studentrecord` VALUES (508, 82.24486336145179, 0.6962813530004223, 0.635954805131028, 41.25300174673793, 0.46165642523923567, 0.4851477686070871, 5, 14, 72.9342125861078, '2025-05-18 07:00:25.565291', '2025-05-18 07:00:25.565291', 510);
INSERT INTO `profile_app_studentrecord` VALUES (507, 100, 0.8353606631983612, 0.8437603118555377, 56.89192465419374, 0.4217390855585174, 0.44920904039083837, 4, 10, 44.609067981775674, '2025-05-18 07:00:25.457292', '2025-05-18 07:00:25.457292', 509);
INSERT INTO `profile_app_studentrecord` VALUES (506, 45.186025925713096, 0.5690525902199226, 0.5673850840092688, 73.77048263764621, 0.6967823324365028, 0.8040158778595426, 6, 11, 67.90113963895527, '2025-05-18 07:00:25.350630', '2025-05-18 07:00:25.350630', 508);
INSERT INTO `profile_app_studentrecord` VALUES (505, 50.80606017917046, 0.5126819694359342, 0.5159966287253485, 58.35274980505877, 0.6477162538598864, 0.5595911204417094, 6, 14, 88.70699249029573, '2025-05-18 07:00:25.244426', '2025-05-18 07:00:25.244426', 507);
INSERT INTO `profile_app_studentrecord` VALUES (504, 46.29018768485906, 0.5235489316781757, 0.7183194327333786, 67.97120165593562, 0.5815690185492054, 0.6432700071794055, 4, 10, 49.78290015208863, '2025-05-18 07:00:25.136426', '2025-05-18 07:00:25.136426', 506);
INSERT INTO `profile_app_studentrecord` VALUES (503, 73.861139249093, 0.7851113220235202, 0.7689659946129741, 61.3557531118614, 0.5025878763361161, 0.47386112412924836, 6, 13, 46.48395239331479, '2025-05-18 07:00:25.029427', '2025-05-18 07:00:25.029427', 505);
INSERT INTO `profile_app_studentrecord` VALUES (502, 53.14311900089579, 0.5570079619232595, 0.5751933259195173, 43.026994964001744, 0.557975252834821, 0.5138612086821085, 5, 13, 79.79306367888556, '2025-05-18 07:00:24.919427', '2025-05-18 07:00:24.919427', 504);
INSERT INTO `profile_app_studentrecord` VALUES (501, 62.10885859456196, 0.6803228195956786, 0.6749537795019271, 55.3248058933029, 0.628206966510361, 0.6203713226217983, 4, 12, 45.6053758664966, '2025-05-18 07:00:24.805344', '2025-05-18 07:00:24.805344', 503);
INSERT INTO `profile_app_studentrecord` VALUES (606, 50, 0.5, 0.4, 60, 0.5, 0.3, 3, 5, 40, '2025-05-19 05:25:32.761062', '2025-05-19 05:25:32.761062', 608);
INSERT INTO `profile_app_studentrecord` VALUES (603, 12, 0.23, 0.12, 32, 0.12, 0.32, 2, 19, 12, '2025-05-18 09:43:07.429126', '2025-05-18 09:43:07.429126', 605);

-- ----------------------------
-- Table structure for profile_app_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `profile_app_userprofile`;
CREATE TABLE `profile_app_userprofile`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `bio` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  UNIQUE INDEX `student_id`(`student_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 611 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of profile_app_userprofile
-- ----------------------------
INSERT INTO `profile_app_userprofile` VALUES (544, '褚凌', 'female', 'student', 544, '202500141', '');
INSERT INTO `profile_app_userprofile` VALUES (543, '魏萱丹', 'female', 'student', 543, '202500140', '');
INSERT INTO `profile_app_userprofile` VALUES (542, '韩兰', 'female', 'student', 542, '202500139', '');
INSERT INTO `profile_app_userprofile` VALUES (541, '尤刚', 'male', 'student', 541, '202500138', '');
INSERT INTO `profile_app_userprofile` VALUES (540, '褚嘉', 'female', 'student', 540, '202500137', '');
INSERT INTO `profile_app_userprofile` VALUES (539, '杨平', 'male', 'student', 539, '202500136', '');
INSERT INTO `profile_app_userprofile` VALUES (538, '曹丽', 'female', 'student', 538, '202500135', '');
INSERT INTO `profile_app_userprofile` VALUES (537, '沈璐', 'female', 'student', 537, '202500134', '');
INSERT INTO `profile_app_userprofile` VALUES (536, '王梦', 'female', 'student', 536, '202500133', '');
INSERT INTO `profile_app_userprofile` VALUES (535, '卫荣', 'male', 'student', 535, '202500132', '');
INSERT INTO `profile_app_userprofile` VALUES (534, '水燕', 'female', 'student', 534, '202500131', '');
INSERT INTO `profile_app_userprofile` VALUES (533, '秦婷', 'female', 'student', 533, '202500130', '');
INSERT INTO `profile_app_userprofile` VALUES (532, '韩霆', 'male', 'student', 532, '202500129', '');
INSERT INTO `profile_app_userprofile` VALUES (531, '卫敏', 'female', 'student', 531, '202500128', '');
INSERT INTO `profile_app_userprofile` VALUES (530, '章洁', 'female', 'student', 530, '202500127', '');
INSERT INTO `profile_app_userprofile` VALUES (529, '秦萍', 'female', 'student', 529, '202500126', '');
INSERT INTO `profile_app_userprofile` VALUES (528, '韩雪娜', 'female', 'student', 528, '202500125', '');
INSERT INTO `profile_app_userprofile` VALUES (527, '蒋杨', 'male', 'student', 527, '202500124', '');
INSERT INTO `profile_app_userprofile` VALUES (526, '杨强雷', 'male', 'student', 526, '202500123', '');
INSERT INTO `profile_app_userprofile` VALUES (525, '吕振', 'male', 'student', 525, '202500122', '');
INSERT INTO `profile_app_userprofile` VALUES (524, '姜军', 'male', 'student', 524, '202500121', '');
INSERT INTO `profile_app_userprofile` VALUES (523, '曹鹏', 'male', 'student', 523, '202500120', '');
INSERT INTO `profile_app_userprofile` VALUES (522, '章彤', 'female', 'student', 522, '202500119', '');
INSERT INTO `profile_app_userprofile` VALUES (521, '吕杰', 'male', 'student', 521, '202500118', '');
INSERT INTO `profile_app_userprofile` VALUES (520, '姜萱', 'female', 'student', 520, '202500117', '');
INSERT INTO `profile_app_userprofile` VALUES (519, '曹睿', 'male', 'student', 519, '202500116', '');
INSERT INTO `profile_app_userprofile` VALUES (518, '李嘉', 'female', 'student', 518, '202500115', '');
INSERT INTO `profile_app_userprofile` VALUES (517, '曹国', 'male', 'student', 517, '202500114', '');
INSERT INTO `profile_app_userprofile` VALUES (516, '施蓉', 'female', 'student', 516, '202500113', '');
INSERT INTO `profile_app_userprofile` VALUES (515, '王宇', 'male', 'student', 515, '202500112', '');
INSERT INTO `profile_app_userprofile` VALUES (514, '许珊', 'female', 'student', 514, '202500111', '');
INSERT INTO `profile_app_userprofile` VALUES (513, '郑芳', 'female', 'student', 513, '202500110', '');
INSERT INTO `profile_app_userprofile` VALUES (512, '陶萱凌', 'female', 'student', 512, '202500109', '');
INSERT INTO `profile_app_userprofile` VALUES (511, '钱姝岚', 'female', 'student', 511, '202500108', '');
INSERT INTO `profile_app_userprofile` VALUES (510, '沈梦', 'female', 'student', 510, '202500107', '');
INSERT INTO `profile_app_userprofile` VALUES (509, '何峰', 'male', 'student', 509, '202500106', '');
INSERT INTO `profile_app_userprofile` VALUES (508, '吕宇', 'male', 'student', 508, '202500105', '');
INSERT INTO `profile_app_userprofile` VALUES (507, '吕俊', 'male', 'student', 507, '202500104', '');
INSERT INTO `profile_app_userprofile` VALUES (506, '张珊', 'female', 'student', 506, '202500103', '');
INSERT INTO `profile_app_userprofile` VALUES (505, '孙洋', 'male', 'student', 505, '202500102', '');
INSERT INTO `profile_app_userprofile` VALUES (504, '窦铭刚', 'male', 'student', 504, '202500101', '');
INSERT INTO `profile_app_userprofile` VALUES (503, '杨旭', 'male', 'student', 503, '202500100', '');
INSERT INTO `profile_app_userprofile` VALUES (502, '周珊', 'female', 'student', 502, '202500099', '');
INSERT INTO `profile_app_userprofile` VALUES (501, '曹静', 'female', 'student', 501, '202500098', '');
INSERT INTO `profile_app_userprofile` VALUES (500, '章杨', 'male', 'student', 500, '202500097', '');
INSERT INTO `profile_app_userprofile` VALUES (499, '张琴', 'female', 'student', 499, '202500096', '');
INSERT INTO `profile_app_userprofile` VALUES (498, '秦荣', 'male', 'student', 498, '202500095', '');
INSERT INTO `profile_app_userprofile` VALUES (497, '章俊刚', 'male', 'student', 497, '202500094', '');
INSERT INTO `profile_app_userprofile` VALUES (496, '郑丹', 'female', 'student', 496, '202500093', '');
INSERT INTO `profile_app_userprofile` VALUES (495, '尤振', 'male', 'student', 495, '202500092', '');
INSERT INTO `profile_app_userprofile` VALUES (494, '杨杰', 'male', 'student', 494, '202500091', '');
INSERT INTO `profile_app_userprofile` VALUES (493, '孙珊丽', 'female', 'student', 493, '202500090', '');
INSERT INTO `profile_app_userprofile` VALUES (492, '章宇', 'male', 'student', 492, '202500089', '');
INSERT INTO `profile_app_userprofile` VALUES (491, '沈嘉', 'female', 'student', 491, '202500088', '');
INSERT INTO `profile_app_userprofile` VALUES (490, '曹丹', 'female', 'student', 490, '202500087', '');
INSERT INTO `profile_app_userprofile` VALUES (489, '柏峰', 'male', 'student', 489, '202500086', '');
INSERT INTO `profile_app_userprofile` VALUES (488, '陈旭', 'male', 'student', 488, '202500085', '');
INSERT INTO `profile_app_userprofile` VALUES (487, '谢岚', 'female', 'student', 487, '202500084', '');
INSERT INTO `profile_app_userprofile` VALUES (486, '魏彤', 'female', 'student', 486, '202500083', '');
INSERT INTO `profile_app_userprofile` VALUES (485, '施琼', 'female', 'student', 485, '202500082', '');
INSERT INTO `profile_app_userprofile` VALUES (484, '蒋琪', 'female', 'student', 484, '202500081', '');
INSERT INTO `profile_app_userprofile` VALUES (483, '陈萱雯', 'female', 'student', 483, '202500080', '');
INSERT INTO `profile_app_userprofile` VALUES (482, '施琳', 'female', 'student', 482, '202500079', '');
INSERT INTO `profile_app_userprofile` VALUES (481, '李瑜', 'female', 'student', 481, '202500078', '');
INSERT INTO `profile_app_userprofile` VALUES (480, '褚坤洋', 'male', 'student', 480, '202500077', '');
INSERT INTO `profile_app_userprofile` VALUES (479, '章辉', 'male', 'student', 479, '202500076', '');
INSERT INTO `profile_app_userprofile` VALUES (478, '吴鑫', 'male', 'student', 478, '202500075', '');
INSERT INTO `profile_app_userprofile` VALUES (477, '张强', 'male', 'student', 477, '202500074', '');
INSERT INTO `profile_app_userprofile` VALUES (476, '章浩', 'male', 'student', 476, '202500073', '');
INSERT INTO `profile_app_userprofile` VALUES (475, '杨霆', 'male', 'student', 475, '202500072', '');
INSERT INTO `profile_app_userprofile` VALUES (474, '赵琪琼', 'female', 'student', 474, '202500071', '');
INSERT INTO `profile_app_userprofile` VALUES (473, '朱健', 'male', 'student', 473, '202500070', '');
INSERT INTO `profile_app_userprofile` VALUES (472, '喻晴蓉', 'female', 'student', 472, '202500069', '');
INSERT INTO `profile_app_userprofile` VALUES (471, '卫瑶', 'female', 'student', 471, '202500068', '');
INSERT INTO `profile_app_userprofile` VALUES (470, '邹盈', 'female', 'student', 470, '202500067', '');
INSERT INTO `profile_app_userprofile` VALUES (469, '赵丽', 'female', 'student', 469, '202500066', '');
INSERT INTO `profile_app_userprofile` VALUES (468, '秦晴', 'female', 'student', 468, '202500065', '');
INSERT INTO `profile_app_userprofile` VALUES (467, '蒋岚', 'female', 'student', 467, '202500064', '');
INSERT INTO `profile_app_userprofile` VALUES (466, '卫强', 'male', 'student', 466, '202500063', '');
INSERT INTO `profile_app_userprofile` VALUES (465, '陶杰', 'male', 'student', 465, '202500062', '');
INSERT INTO `profile_app_userprofile` VALUES (464, '杨红', 'female', 'student', 464, '202500061', '');
INSERT INTO `profile_app_userprofile` VALUES (463, '尤雪', 'female', 'student', 463, '202500060', '');
INSERT INTO `profile_app_userprofile` VALUES (462, '邹琴怡', 'female', 'student', 462, '202500059', '');
INSERT INTO `profile_app_userprofile` VALUES (461, '窦梦', 'female', 'student', 461, '202500058', '');
INSERT INTO `profile_app_userprofile` VALUES (460, '严浩', 'male', 'student', 460, '202500057', '');
INSERT INTO `profile_app_userprofile` VALUES (459, '柏彤兰', 'female', 'student', 459, '202500056', '');
INSERT INTO `profile_app_userprofile` VALUES (458, '韩琴', 'female', 'student', 458, '202500055', '');
INSERT INTO `profile_app_userprofile` VALUES (456, '孙丽瑜', 'female', 'student', 456, '202500053', '');
INSERT INTO `profile_app_userprofile` VALUES (455, '卫明杨', 'male', 'student', 455, '202500052', '');
INSERT INTO `profile_app_userprofile` VALUES (454, '戚睿', 'male', 'student', 454, '202500051', '');
INSERT INTO `profile_app_userprofile` VALUES (453, '喻琼', 'female', 'student', 453, '202500050', '');
INSERT INTO `profile_app_userprofile` VALUES (452, '姜嘉', 'female', 'student', 452, '202500049', '');
INSERT INTO `profile_app_userprofile` VALUES (451, '王霆', 'male', 'student', 451, '202500048', '');
INSERT INTO `profile_app_userprofile` VALUES (450, '褚莉', 'female', 'student', 450, '202500047', '');
INSERT INTO `profile_app_userprofile` VALUES (449, '窦睿睿', 'male', 'student', 449, '202500046', '');
INSERT INTO `profile_app_userprofile` VALUES (448, '冯荣宁', 'male', 'student', 448, '202500045', '');
INSERT INTO `profile_app_userprofile` VALUES (447, '施旭', 'male', 'student', 447, '202500044', '');
INSERT INTO `profile_app_userprofile` VALUES (446, '章桂', 'female', 'student', 446, '202500043', '');
INSERT INTO `profile_app_userprofile` VALUES (445, '张彤', 'female', 'student', 445, '202500042', '');
INSERT INTO `profile_app_userprofile` VALUES (444, '邹梦', 'female', 'student', 444, '202500041', '');
INSERT INTO `profile_app_userprofile` VALUES (443, '吕鹏', 'male', 'student', 443, '202500040', '');
INSERT INTO `profile_app_userprofile` VALUES (442, '陶睿杨', 'male', 'student', 442, '202500039', '');
INSERT INTO `profile_app_userprofile` VALUES (441, '李丹', 'female', 'student', 441, '202500038', '');
INSERT INTO `profile_app_userprofile` VALUES (440, '杨凌', 'female', 'student', 440, '202500037', '');
INSERT INTO `profile_app_userprofile` VALUES (439, '李伟', 'male', 'student', 439, '202500036', '');
INSERT INTO `profile_app_userprofile` VALUES (438, '孔瑜', 'female', 'student', 438, '202500035', '');
INSERT INTO `profile_app_userprofile` VALUES (437, '卫诚', 'male', 'student', 437, '202500034', '');
INSERT INTO `profile_app_userprofile` VALUES (436, '韩琼', 'female', 'student', 436, '202500033', '');
INSERT INTO `profile_app_userprofile` VALUES (435, '冯璐', 'female', 'student', 435, '202500032', '');
INSERT INTO `profile_app_userprofile` VALUES (434, '柏萱', 'female', 'student', 434, '202500031', '');
INSERT INTO `profile_app_userprofile` VALUES (433, '孙盈', 'female', 'student', 433, '202500030', '');
INSERT INTO `profile_app_userprofile` VALUES (432, '邹勇', 'male', 'student', 432, '202500029', '');
INSERT INTO `profile_app_userprofile` VALUES (431, '水亮', 'male', 'student', 431, '202500028', '');
INSERT INTO `profile_app_userprofile` VALUES (430, '赵霞', 'female', 'student', 430, '202500027', '');
INSERT INTO `profile_app_userprofile` VALUES (429, '李红', 'female', 'student', 429, '202500026', '');
INSERT INTO `profile_app_userprofile` VALUES (428, '赵佳铭', 'male', 'student', 428, '202500025', '');
INSERT INTO `profile_app_userprofile` VALUES (427, '章铭', 'male', 'student', 427, '202500024', '');
INSERT INTO `profile_app_userprofile` VALUES (426, '窦浩振', 'male', 'student', 426, '202500023', '');
INSERT INTO `profile_app_userprofile` VALUES (425, '姜岚', 'female', 'student', 425, '202500022', '');
INSERT INTO `profile_app_userprofile` VALUES (424, '李珊婉', 'female', 'student', 424, '202500021', '');
INSERT INTO `profile_app_userprofile` VALUES (423, '秦杨', 'male', 'student', 423, '202500020', '');
INSERT INTO `profile_app_userprofile` VALUES (422, '戚静岚', 'female', 'student', 422, '202500019', '');
INSERT INTO `profile_app_userprofile` VALUES (421, '水琪', 'female', 'student', 421, '202500018', '');
INSERT INTO `profile_app_userprofile` VALUES (420, '王红桂', 'female', 'student', 420, '202500017', '');
INSERT INTO `profile_app_userprofile` VALUES (419, '赵伟', 'male', 'student', 419, '202500016', '');
INSERT INTO `profile_app_userprofile` VALUES (418, '褚萍萍', 'female', 'student', 418, '202500015', '');
INSERT INTO `profile_app_userprofile` VALUES (417, '钱怡嘉', 'female', 'student', 417, '202500014', '');
INSERT INTO `profile_app_userprofile` VALUES (416, '严莉', 'female', 'student', 416, '202500013', '');
INSERT INTO `profile_app_userprofile` VALUES (415, '李宁', 'male', 'student', 415, '202500012', '');
INSERT INTO `profile_app_userprofile` VALUES (414, '金雪颖', 'female', 'student', 414, '202500011', '');
INSERT INTO `profile_app_userprofile` VALUES (413, '钱婉姝', 'female', 'student', 413, '202500010', '');
INSERT INTO `profile_app_userprofile` VALUES (412, '韩璐', 'female', 'student', 412, '202500009', '');
INSERT INTO `profile_app_userprofile` VALUES (411, '卫萍姝', 'female', 'student', 411, '202500008', '');
INSERT INTO `profile_app_userprofile` VALUES (410, '朱雪', 'female', 'student', 410, '202500007', '');
INSERT INTO `profile_app_userprofile` VALUES (409, '章敏丹', 'female', 'student', 409, '202500006', '');
INSERT INTO `profile_app_userprofile` VALUES (408, '褚萍', 'female', 'student', 408, '202500005', '');
INSERT INTO `profile_app_userprofile` VALUES (407, '戚莉', 'female', 'student', 407, '202500004', '');
INSERT INTO `profile_app_userprofile` VALUES (406, '陈洁', 'female', 'student', 406, '202500003', '');
INSERT INTO `profile_app_userprofile` VALUES (405, '陈琪桂', 'female', 'student', 405, '202500002', '');
INSERT INTO `profile_app_userprofile` VALUES (404, '陈霞红', 'female', 'student', 404, '202500001', '');
INSERT INTO `profile_app_userprofile` VALUES (545, '吕雷睿', 'male', 'student', 545, '202500142', '');
INSERT INTO `profile_app_userprofile` VALUES (546, '吴兰', 'female', 'student', 546, '202500143', '');
INSERT INTO `profile_app_userprofile` VALUES (547, '邹俊', 'male', 'student', 547, '202500144', '');
INSERT INTO `profile_app_userprofile` VALUES (548, '钱岚颖', 'female', 'student', 548, '202500145', '');
INSERT INTO `profile_app_userprofile` VALUES (549, '张坤', 'male', 'student', 549, '202500146', '');
INSERT INTO `profile_app_userprofile` VALUES (550, '吕琪', 'female', 'student', 550, '202500147', '');
INSERT INTO `profile_app_userprofile` VALUES (551, '王彤', 'female', 'student', 551, '202500148', '');
INSERT INTO `profile_app_userprofile` VALUES (552, '吕亮', 'male', 'student', 552, '202500149', '');
INSERT INTO `profile_app_userprofile` VALUES (553, '冯凌', 'female', 'student', 553, '202500150', '');
INSERT INTO `profile_app_userprofile` VALUES (554, '章琪', 'female', 'student', 554, '202500151', '');
INSERT INTO `profile_app_userprofile` VALUES (555, '秦雷鹏', 'male', 'student', 555, '202500152', '');
INSERT INTO `profile_app_userprofile` VALUES (556, '陈振', 'male', 'student', 556, '202500153', '');
INSERT INTO `profile_app_userprofile` VALUES (557, '杨盈琳', 'female', 'student', 557, '202500154', '');
INSERT INTO `profile_app_userprofile` VALUES (558, '施月', 'female', 'student', 558, '202500155', '');
INSERT INTO `profile_app_userprofile` VALUES (559, '褚月嘉', 'female', 'student', 559, '202500156', '');
INSERT INTO `profile_app_userprofile` VALUES (560, '赵鹏峰', 'male', 'student', 560, '202500157', '');
INSERT INTO `profile_app_userprofile` VALUES (561, '沈雷俊', 'male', 'student', 561, '202500158', '');
INSERT INTO `profile_app_userprofile` VALUES (562, '喻婷莉', 'female', 'student', 562, '202500159', '');
INSERT INTO `profile_app_userprofile` VALUES (563, '邹雯', 'female', 'student', 563, '202500160', '');
INSERT INTO `profile_app_userprofile` VALUES (564, '李莉', 'female', 'student', 564, '202500161', '');
INSERT INTO `profile_app_userprofile` VALUES (565, '施诚彬', 'male', 'student', 565, '202500162', '');
INSERT INTO `profile_app_userprofile` VALUES (566, '沈亮', 'male', 'student', 566, '202500163', '');
INSERT INTO `profile_app_userprofile` VALUES (567, '邹瑶', 'female', 'student', 567, '202500164', '');
INSERT INTO `profile_app_userprofile` VALUES (568, '沈洁敏', 'female', 'student', 568, '202500165', '');
INSERT INTO `profile_app_userprofile` VALUES (569, '孔蓉', 'female', 'student', 569, '202500166', '');
INSERT INTO `profile_app_userprofile` VALUES (570, '姜桂', 'female', 'student', 570, '202500167', '');
INSERT INTO `profile_app_userprofile` VALUES (571, '水国', 'male', 'student', 571, '202500168', '');
INSERT INTO `profile_app_userprofile` VALUES (572, '孙龙泽', 'male', 'student', 572, '202500169', '');
INSERT INTO `profile_app_userprofile` VALUES (573, '孙丽', 'female', 'student', 573, '202500170', '');
INSERT INTO `profile_app_userprofile` VALUES (574, '卫雪', 'female', 'student', 574, '202500171', '');
INSERT INTO `profile_app_userprofile` VALUES (575, '华泽杨', 'male', 'student', 575, '202500172', '');
INSERT INTO `profile_app_userprofile` VALUES (576, '许芳', 'female', 'student', 576, '202500173', '');
INSERT INTO `profile_app_userprofile` VALUES (577, '谢诚杰', 'male', 'student', 577, '202500174', '');
INSERT INTO `profile_app_userprofile` VALUES (578, '孙睿刚', 'male', 'student', 578, '202500175', '');
INSERT INTO `profile_app_userprofile` VALUES (579, '卫珊蓉', 'female', 'student', 579, '202500176', '');
INSERT INTO `profile_app_userprofile` VALUES (580, '周杨', 'male', 'student', 580, '202500177', '');
INSERT INTO `profile_app_userprofile` VALUES (581, '陶彤桂', 'female', 'student', 581, '202500178', '');
INSERT INTO `profile_app_userprofile` VALUES (582, '尤健雷', 'male', 'student', 582, '202500179', '');
INSERT INTO `profile_app_userprofile` VALUES (583, '郑勇', 'male', 'student', 583, '202500180', '');
INSERT INTO `profile_app_userprofile` VALUES (584, '周荣', 'male', 'student', 584, '202500181', '');
INSERT INTO `profile_app_userprofile` VALUES (585, '吕健', 'male', 'student', 585, '202500182', '');
INSERT INTO `profile_app_userprofile` VALUES (586, '冯振', 'male', 'student', 586, '202500183', '');
INSERT INTO `profile_app_userprofile` VALUES (587, '钱铭', 'male', 'student', 587, '202500184', '');
INSERT INTO `profile_app_userprofile` VALUES (589, '褚超诚', 'male', 'student', 589, '202500186', '');
INSERT INTO `profile_app_userprofile` VALUES (590, '吕丽', 'female', 'student', 590, '202500187', '');
INSERT INTO `profile_app_userprofile` VALUES (591, '张蓉', 'female', 'student', 591, '202500188', '');
INSERT INTO `profile_app_userprofile` VALUES (592, '钱盈', 'female', 'student', 592, '202500189', '');
INSERT INTO `profile_app_userprofile` VALUES (593, '魏娜', 'female', 'student', 593, '202500190', '');
INSERT INTO `profile_app_userprofile` VALUES (594, '李娜婉', 'female', 'student', 594, '202500191', '');
INSERT INTO `profile_app_userprofile` VALUES (595, '姜彤', 'female', 'student', 595, '202500192', '');
INSERT INTO `profile_app_userprofile` VALUES (612, '长得帅', 'male', 'student', 612, '202500203', '');
INSERT INTO `profile_app_userprofile` VALUES (597, '水雷', 'male', 'student', 597, '202500194', '');
INSERT INTO `profile_app_userprofile` VALUES (598, '施雷', 'male', 'student', 598, '202500195', '');
INSERT INTO `profile_app_userprofile` VALUES (599, '何飞', 'male', 'student', 599, '202500196', '');
INSERT INTO `profile_app_userprofile` VALUES (600, '秦杰', 'male', 'student', 600, '202500197', '');
INSERT INTO `profile_app_userprofile` VALUES (601, '周强', 'male', 'student', 601, '202500198', '');
INSERT INTO `profile_app_userprofile` VALUES (602, '褚丹', 'female', 'student', 602, '202500199', '');
INSERT INTO `profile_app_userprofile` VALUES (603, 'student00200', 'male', 'student', 603, '202500200', '');
INSERT INTO `profile_app_userprofile` VALUES (605, '测试用户', 'male', 'student', 605, '2021021745', '');
INSERT INTO `profile_app_userprofile` VALUES (610, 'admin', 'unknown', 'admin', 610, NULL, '');
INSERT INTO `profile_app_userprofile` VALUES (608, '测试用户222', 'male', 'student', 608, '202500201', '');
INSERT INTO `profile_app_userprofile` VALUES (611, 'aaabb', 'male', 'student', 611, '202500202', '');

SET FOREIGN_KEY_CHECKS = 1;
