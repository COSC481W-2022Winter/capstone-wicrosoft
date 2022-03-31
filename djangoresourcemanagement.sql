-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 31, 2022 at 12:02 AM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `djangocelebrityhater`
--
CREATE DATABASE IF NOT EXISTS `djangocelebrityhater` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `djangocelebrityhater`;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add account', 6, 'add_account'),
(22, 'Can change account', 6, 'change_account'),
(23, 'Can delete account', 6, 'delete_account'),
(24, 'Can view account', 6, 'view_account'),
(25, 'Can add celebrity', 7, 'add_celebrity'),
(26, 'Can change celebrity', 7, 'change_celebrity'),
(27, 'Can delete celebrity', 7, 'delete_celebrity'),
(28, 'Can view celebrity', 7, 'view_celebrity'),
(29, 'Can add likes', 8, 'add_likes'),
(30, 'Can change likes', 8, 'change_likes'),
(31, 'Can delete likes', 8, 'delete_likes'),
(32, 'Can view likes', 8, 'view_likes'),
(33, 'Can add hates', 9, 'add_hates'),
(34, 'Can change hates', 9, 'change_hates'),
(35, 'Can delete hates', 9, 'delete_hates'),
(36, 'Can view hates', 9, 'view_hates');

-- --------------------------------------------------------

--
-- Table structure for table `celebrityhater_account`
--

CREATE TABLE `celebrityhater_account` (
  `id` bigint(20) NOT NULL,
  `password` varchar(150) NOT NULL,
  `email` varchar(60) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `celebrityhater_account`
--

INSERT INTO `celebrityhater_account` (`id`, `password`, `email`, `firstName`, `lastName`, `date_joined`, `last_login`, `is_admin`, `is_staff`, `is_superuser`, `is_active`) VALUES
(1, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'briansimmons918@gmail.com', 'Brian', 'Simmons', '2022-01-05 21:51:00.000000', '2022-01-24 17:05:10.021367', 0, 0, 0, 1),
(2, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'jameshunt@doge.com', 'James', 'Hunt', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(3, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'samhunt@doge.com', 'Sam', 'Hunt', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(4, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'toddmcfarlane@doge.com', 'Todd', 'Mcfarlane', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(5, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'scottsnyder@doge.com', 'Scott', 'Snyder', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(6, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'thomasshank@doge.com', 'Thomas', 'Shank', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(7, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'elijahdean@doge.com', 'Elijah', 'Dean', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(8, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'alexhaak@doge.com', 'Alex', 'Haak', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(9, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'kenmasters@doge.com', 'Ken', 'Masters', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(10, 'pbkdf2_sha256$320000$ltWzANqmBBG66KIqS2ljlp$D5EURAxDePpQZos2VH0Qs+LtRxSO8yUvdA7DZskhe8k=', 'ruihachimura@doge.com', 'Rui', 'Hachimura', '2022-01-05 21:51:00.000000', '2022-01-05 21:51:00.000000', 0, 0, 0, 1),
(11, 'pbkdf2_sha256$320000$Y0VXqzr5WUnOatb1Rxtx8H$wfAS3XKJr12/V8pRyRGPOf4/NlHfg1cN6nUSe1JQFYE=', 'jelwell4@emich.edu', 'Jacob', 'Elwell', '2022-01-24 17:27:30.686279', '2022-01-24 20:19:21.028350', 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `celebrityhater_celebrity`
--

CREATE TABLE `celebrityhater_celebrity` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `movies` longtext,
  `howManyLikes` int(11) DEFAULT NULL,
  `howManyHates` int(11) DEFAULT NULL,
  `mainMovieGenre` varchar(6) NOT NULL,
  `profession` varchar(75) NOT NULL,
  `biography` longtext,
  `imgurl` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `celebrityhater_celebrity`
--

INSERT INTO `celebrityhater_celebrity` (`id`, `name`, `movies`, `howManyLikes`, `howManyHates`, `mainMovieGenre`, `profession`, `biography`, `imgurl`) VALUES
(1, 'Johnathan Majors', 'The Harder They Fall, Marvel\'s Loki, Lovecraft Country', 0, 0, 'DRAMA', 'ACT', 'Jonathan Majors (born September 7, 1989) is an American actor. He rose to prominence after starring in the independent feature film The Last Black Man in San Francisco (2019). In 2020, he garnered wider notice for portraying Atticus Freeman in the HBO television series Lovecraft Country. He appears as He Who Remains in the Disney+ series Loki (2021), and will appear as another version of that character, Kang the Conqueror, in the film Ant-Man and the Wasp: Quantumania (2023).', '/images/celebrities/jm.jpg'),
(2, 'Andrew Garfield', 'The Amazing Spider-Man, Hacksaw Ridge, The Social Network', 0, 0, 'DRAMA', 'ACT', 'Andrew Russell Garfield (born 20 August 1983) is a British-American actor. An alumnus of the Royal Central School of Speech and Drama, he is the recipient of various accolades, including a Tony Award, a British Academy Television Award, and a Golden Globe Award.\n\nBorn in Los Angeles and raised in Epsom, England, Garfield began his career on the UK stage and in television productions. He made his feature-film debut in the 2007 ensemble drama Lions for Lambs. Also that year, his performance in the television film Boy A earned him a BAFTA for Best Actor. He came to international attention in 2010 with supporting roles in the drama The Social Network, for which he received BAFTA and Golden Globe nominations portraying Eduardo Saverin, and the science-fiction romance Never Let Me Go. Garfield subsequently gained wider recognition for playing Spider-Man in the superhero film The Amazing Spider-Man (2012) and its 2014 sequel. In 2016, Garfield starred in the historical dramas Mel Gibson\'s war film Hacksaw Ridge and Martin Scorsese\'s religious epic Silence. His portrayal of Desmond T. Doss in the former earned him nominations for an Academy Award, BAFTA Award, Screen Actors Guild Award, and Golden Globe Award, all for Best Actor. In 2021, he portrayed Jonathan Larson in the musical Tick, Tick... Boom! and reprised his role as Spider-Man in Spider-Man: No Way Home. The former earned Garfield his first Golden Globe Award. ', '/images/celebrities/ag.jpg'),
(3, 'Regina King', 'Watchmen (2019), If Beale Street Could Talk, The Harder They Fall', 0, 0, 'DRAMA', 'ACTR', 'Regina Rene King (born January 15, 1971) is an American actress and director. She is the recipient of various accolades, including an Academy Award, a Golden Globe Award, and four Primetime Emmy Awards, the most for an African-American performer. In 2019, Time magazine named her one of the 100 most influential people in the world.\n\nKing first gained attention for her role as Brenda Jenkins in the television series 227 from 1985 to 1990. Notable roles followed in the films Friday (1995), animated series The Boondocks (2005–2014), and the crime television series Southland (2009–2013). From 2015 to 2017, King starred in the ABC anthology series American Crime, for which she won two Primetime Emmy Awards, and in 2018, she starred in the Netflix miniseries Seven Seconds, for which she won her third Emmy Award. She starred in Barry Jenkins\' film adaptation of the James Baldwin novel If Beale Street Could Talk (2018). For her performance, she won the Academy Award for Best Supporting Actress and the Golden Globe Award for Best Supporting Actress. King won her fourth Emmy Award for starring in the dystopian superhero limited series Watchmen (2019). ', '/images/celebrities/rk.jpg'),
(4, 'Lakeith Stanfield', 'Judas and the Black Messiah, Atlanta, Knives Out', 0, 0, 'DRAMA', 'ACT', 'LaKeith Lee Stanfield (born August 12, 1991) is an American actor and musician. He made his feature film debut in Short Term 12 (2013), for which he was nominated for an Independent Spirit Award. He received further recognition for his roles in the films Selma (2014), Straight Outta Compton (2015), Crown Heights (2017), Sorry to Bother You (2018), and Judas and the Black Messiah (2021), the lattermost of which earned him an Academy Award nomination.\n\nStanfield has also appeared in the films Dope (2015), Get Out (2017), Uncut Gems (2019), Knives Out (2019), The Photograph (2020) and The Harder They Fall (2021), and starred in the series Atlanta (2016–present), for which he won a Black Reel Award for Television. He has been nominated for a Critics\' Choice Movie Award, a Gotham Award, two Satellite Awards, two Screen Actors Guild Awards, and five Black Reel Awards. ', '/images/celebrities/ls.jpg'),
(5, 'Idris Elba', 'The Suicide Squad, The Wire, Pacific Rim', 0, 0, 'DRAMA', 'ACT', 'Idrissa Akuna Elba OBE (/ˈɪdrɪs/; born 6 September 1972) is an English actor, producer and musician. He is known for roles including Stringer Bell in the HBO series The Wire, DCI John Luther in the BBC One series Luther, and Nelson Mandela in the biographical film Mandela: Long Walk to Freedom (2013). He has been nominated four times for a Golden Globe Award for Best Actor – Miniseries or Television Film, winning one, and has been nominated five times for a Primetime Emmy Award.\n\nElba appeared in Ridley Scott\'s American Gangster (2007) and Prometheus (2012). Elba portrayed Heimdall in Thor (2011) and its sequels Thor: The Dark World (2013) and Thor: Ragnarok (2017), as well as Avengers: Age of Ultron (2015) and Avengers: Infinity War (2018). He also starred in Pacific Rim (2013), Beasts of No Nation (2015), for which he received Golden Globe and BAFTA nominations for Best Supporting Actor, and Molly\'s Game (2017). In 2016, he voiced Chief Bogo in Zootopia, Shere Khan in the live action/CGI adaptation of The Jungle Book, Fluke in Finding Dory, and played the role of Krall in Star Trek Beyond. He made his directorial debut in 2018 with an adaptation of the 1992 novel Yardie by Victor Headley. In 2021, he portrayed Bloodsport in The Suicide Squad, set in the DC Extended Universe.\n\nAside from acting, Elba performs as a DJ under the moniker DJ Big Driis (or Big Driis the Londoner) and as an R&B musician. In 2016, he was named in the Time 100 list of the Most Influential People in the World. As of May 2019, his films have grossed over $9.8 billion at the global box office, including over $3.6 billion in North America, where he is one of the top 20 highest-grossing actors.', '/images/celebrities/ie.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `celebrityhater_hates`
--

CREATE TABLE `celebrityhater_hates` (
  `id` bigint(20) NOT NULL,
  `celebrity_id` bigint(20) DEFAULT NULL,
  `hater_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `celebrityhater_likes`
--

CREATE TABLE `celebrityhater_likes` (
  `id` bigint(20) NOT NULL,
  `celebrity_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `celebrityhater_likes`
--

INSERT INTO `celebrityhater_likes` (`id`, `celebrity_id`, `user_id`) VALUES
(2, 3, 1),
(4, 1, 11),
(5, 3, 11);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(6, 'CelebrityHater', 'account'),
(7, 'CelebrityHater', 'celebrity'),
(9, 'CelebrityHater', 'hates'),
(8, 'CelebrityHater', 'likes'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'CelebrityHater', '0001_initial', '2022-01-17 18:02:37.551226'),
(2, 'contenttypes', '0001_initial', '2022-01-17 18:02:37.614598'),
(3, 'admin', '0001_initial', '2022-01-17 18:02:37.780156'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-01-17 18:02:37.785143'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-01-17 18:02:37.790129'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-01-17 18:02:37.891856'),
(7, 'auth', '0001_initial', '2022-01-17 18:02:38.207135'),
(8, 'auth', '0002_alter_permission_name_max_length', '2022-01-17 18:02:38.272983'),
(9, 'auth', '0003_alter_user_email_max_length', '2022-01-17 18:02:38.277946'),
(10, 'auth', '0004_alter_user_username_opts', '2022-01-17 18:02:38.282933'),
(11, 'auth', '0005_alter_user_last_login_null', '2022-01-17 18:02:38.288917'),
(12, 'auth', '0006_require_contenttypes_0002', '2022-01-17 18:02:38.291909'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2022-01-17 18:02:38.296895'),
(14, 'auth', '0008_alter_user_username_max_length', '2022-01-17 18:02:38.301882'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2022-01-17 18:02:38.307866'),
(16, 'auth', '0010_alter_group_name_max_length', '2022-01-17 18:02:38.370699'),
(17, 'auth', '0011_update_proxy_permissions', '2022-01-17 18:02:38.377680'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2022-01-17 18:02:38.384661'),
(19, 'sessions', '0001_initial', '2022-01-17 18:02:38.432533'),
(20, 'CelebrityHater', '0002_alter_account_password', '2022-01-17 18:13:12.455057'),
(21, 'CelebrityHater', '0003_celebrity_profession', '2022-01-17 18:25:53.409653'),
(22, 'CelebrityHater', '0004_celebrity_biography', '2022-01-17 18:27:55.549451'),
(23, 'CelebrityHater', '0005_celebrity_imgurl', '2022-01-17 18:33:41.584947');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `celebrityhater_account`
--
ALTER TABLE `celebrityhater_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `celebrityhater_celebrity`
--
ALTER TABLE `celebrityhater_celebrity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `celebrityhater_hates`
--
ALTER TABLE `celebrityhater_hates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CelebrityHater_hates_celebrity_id_a86df80a_fk_Celebrity` (`celebrity_id`),
  ADD KEY `CelebrityHater_hates_hater_id_80142ba0_fk_Celebrity` (`hater_id`);

--
-- Indexes for table `celebrityhater_likes`
--
ALTER TABLE `celebrityhater_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CelebrityHater_likes_celebrity_id_34f28fbb_fk_Celebrity` (`celebrity_id`),
  ADD KEY `CelebrityHater_likes_user_id_bb0362ba_fk_Celebrity` (`user_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_CelebrityHater_account_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `celebrityhater_account`
--
ALTER TABLE `celebrityhater_account`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `celebrityhater_celebrity`
--
ALTER TABLE `celebrityhater_celebrity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `celebrityhater_hates`
--
ALTER TABLE `celebrityhater_hates`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `celebrityhater_likes`
--
ALTER TABLE `celebrityhater_likes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `celebrityhater_hates`
--
ALTER TABLE `celebrityhater_hates`
  ADD CONSTRAINT `CelebrityHater_hates_celebrity_id_a86df80a_fk_Celebrity` FOREIGN KEY (`celebrity_id`) REFERENCES `celebrityhater_celebrity` (`id`),
  ADD CONSTRAINT `CelebrityHater_hates_hater_id_80142ba0_fk_Celebrity` FOREIGN KEY (`hater_id`) REFERENCES `celebrityhater_account` (`id`);

--
-- Constraints for table `celebrityhater_likes`
--
ALTER TABLE `celebrityhater_likes`
  ADD CONSTRAINT `CelebrityHater_likes_celebrity_id_34f28fbb_fk_Celebrity` FOREIGN KEY (`celebrity_id`) REFERENCES `celebrityhater_celebrity` (`id`),
  ADD CONSTRAINT `CelebrityHater_likes_user_id_bb0362ba_fk_Celebrity` FOREIGN KEY (`user_id`) REFERENCES `celebrityhater_account` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_CelebrityHater_account_id` FOREIGN KEY (`user_id`) REFERENCES `celebrityhater_account` (`id`);
--
-- Database: `djangoresourcemanagement`
--
CREATE DATABASE IF NOT EXISTS `djangoresourcemanagement` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `djangoresourcemanagement`;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add users', 6, 'add_users'),
(22, 'Can change users', 6, 'change_users'),
(23, 'Can delete users', 6, 'delete_users'),
(24, 'Can view users', 6, 'view_users'),
(25, 'Can add announcements', 7, 'add_announcements'),
(26, 'Can change announcements', 7, 'change_announcements'),
(27, 'Can delete announcements', 7, 'delete_announcements'),
(28, 'Can view announcements', 7, 'view_announcements'),
(29, 'Can add proficiency levels', 8, 'add_proficiencylevels'),
(30, 'Can change proficiency levels', 8, 'change_proficiencylevels'),
(31, 'Can delete proficiency levels', 8, 'delete_proficiencylevels'),
(32, 'Can view proficiency levels', 8, 'view_proficiencylevels'),
(33, 'Can add projects', 9, 'add_projects'),
(34, 'Can change projects', 9, 'change_projects'),
(35, 'Can delete projects', 9, 'delete_projects'),
(36, 'Can view projects', 9, 'view_projects'),
(37, 'Can add resources', 10, 'add_resources'),
(38, 'Can change resources', 10, 'change_resources'),
(39, 'Can delete resources', 10, 'delete_resources'),
(40, 'Can view resources', 10, 'view_resources'),
(41, 'Can add roles', 11, 'add_roles'),
(42, 'Can change roles', 11, 'change_roles'),
(43, 'Can delete roles', 11, 'delete_roles'),
(44, 'Can view roles', 11, 'view_roles'),
(45, 'Can add squad members', 12, 'add_squadmembers'),
(46, 'Can change squad members', 12, 'change_squadmembers'),
(47, 'Can delete squad members', 12, 'delete_squadmembers'),
(48, 'Can view squad members', 12, 'view_squadmembers'),
(49, 'Can add tech skill', 13, 'add_techskill'),
(50, 'Can change tech skill', 13, 'change_techskill'),
(51, 'Can delete tech skill', 13, 'delete_techskill'),
(52, 'Can view tech skill', 13, 'view_techskill'),
(53, 'Can add user to skill', 14, 'add_usertoskill'),
(54, 'Can change user to skill', 14, 'change_usertoskill'),
(55, 'Can delete user to skill', 14, 'delete_usertoskill'),
(56, 'Can view user to skill', 14, 'view_usertoskill'),
(57, 'Can add teams', 15, 'add_teams'),
(58, 'Can change teams', 15, 'change_teams'),
(59, 'Can delete teams', 15, 'delete_teams'),
(60, 'Can view teams', 15, 'view_teams');

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_announcements`
--

CREATE TABLE `djangoresourcemanagement_announcements` (
  `id` bigint(20) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `announcement_date` datetime(6) NOT NULL,
  `author_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_announcements`
--

INSERT INTO `djangoresourcemanagement_announcements` (`id`, `title`, `description`, `announcement_date`, `author_id`) VALUES
(1, 'Trello Update', 'An update to the Trello labels has been made, please review them and respond accordingly', '2022-02-14 20:58:00.000000', 2);

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_announcements_announcement_to_resource`
--

CREATE TABLE `djangoresourcemanagement_announcements_announcement_to_resource` (
  `id` bigint(20) NOT NULL,
  `announcements_id` bigint(20) NOT NULL,
  `resources_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_proficiencylevels`
--

CREATE TABLE `djangoresourcemanagement_proficiencylevels` (
  `id` bigint(20) NOT NULL,
  `level_name` varchar(10) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_proficiencylevels`
--

INSERT INTO `djangoresourcemanagement_proficiencylevels` (`id`, `level_name`, `description`) VALUES
(1, 'BEG', 'Uses basic understanding of the field to perform job duties; may need some guidance on job duties; applies learning to recommend options to address unusual situations.'),
(2, 'INT', 'uccessfully completes diverse tasks of the job; applies and enhances knowledge and skill in both usual and unusual issues; needs minimal guidance in addressing unusual situations.'),
(3, 'ADV', 'Performs without assistance; recognized as a resource to others; able to translate complex nuances to others; able to improve processes; focus on broad issues.'),
(4, 'EXP', 'Seen as an expert and/or leader; guides, troubleshoots; has strategic focus; applies knowledge and skill across or in leading multiple projects/orgs; demonstrates knowledge of trends in field; leads in developing new processes.');

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_projects`
--

CREATE TABLE `djangoresourcemanagement_projects` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `short_description` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `projected_end_date` datetime(6) NOT NULL,
  `actual_end_date` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `type` varchar(3) NOT NULL,
  `project_owner_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_projects`
--

INSERT INTO `djangoresourcemanagement_projects` (`id`, `name`, `short_description`, `description`, `start_date`, `projected_end_date`, `actual_end_date`, `is_active`, `type`, `project_owner_id`) VALUES
(1, 'Dashboard Display', 'Create graphical display for the employee dashboard', 'Graphical display to include productivity log, trello boards tab, as well as clock time', '2022-02-14 20:58:00.000000', '2022-03-15 20:00:00.000000', NULL, 1, 'PUB', 2),
(2, 'Omozan Inventory', 'Omozan Inventory will be a application built from the ground up to manage the inventory of various warehouses throughout America.', 'Key Features of the Omozan Inventory Application:\r\n\r\n- Updates on the fly as items are shipped and received at a warehouse\r\n- Tracking for individual packages\r\n- Data Collection on item purchase / time in warehouse / demand \r\n- Integrated with Handheld devices used by warehouse and shipping personnel', '2022-03-30 15:35:40.000000', '2022-11-20 15:35:40.000000', NULL, 1, 'PUB', NULL),
(3, 'FaceVideo Data Collection', 'FaceVideo Data Collection will be an analytical tool application designed to process user data and recordings.\r\n', 'FaceVideo Data Collection will be an analytical tool application designed to process user data and recordings of users using the FaceVideo app to guide the improvement of the app experience. \r\n\r\nKey Features:\r\n\r\n- Gathers Data pertaining too:\r\n   - Audio Levels of input and output\r\n   - Audio quality\r\n   - Lighting / Brightness of environment\r\n   - Times of use / duration of use\r\n   - Movement of image\r\n   - Basic Specifications of devices using app\r\n   - Basic User Data (Age, Location, Sex)\r\n\r\n- Sorts / Graphs data into easy-to-use interfaces for analysis\r\n\r\n- Compiles Customer Reviews and returns common themes for either praises / bugs / desired features\r\n\r\n\r\n   ', '2022-01-03 15:46:58.000000', '2022-08-26 15:46:58.000000', NULL, 1, 'PUB', NULL),
(4, 'Pear Calendar', 'Pear Calendar will be an integrated calendar application in all Pear devices.', 'Pear Calendar is making a more modern and integrated calendar system that works seamlessly with existing email / online calendars / task management so users can have all important dates / tasks located in all user Pear devices. \r\n\r\nKey Features:\r\n  - Backwards Compatible \r\n  - Pulls data from users oogleDrive / Calendar or other email system\r\n  - Works with various top of the line / common company calendars\r\n  - Can be viewed from any Pear Device (Laptop, phone, watch, Upad)\r\n  - Work with various task management systems such as Trello', '2022-02-14 16:00:04.000000', '2022-09-16 16:00:04.000000', NULL, 1, 'PUB', NULL),
(5, 'Life Delights In-Store Point-of-Sale Application', 'Life Delights is creating a new application for easy to use in-store sales and data collection', 'Life Delights In-Store Point-of-Sale Application will be the system used by this local bakery for sales of all items sold at the store. In addition to completing transactions, the system will collect and save important data pertaining to sales to help guide future decisions. \r\n\r\nKey Features:\r\n  - Completes transactions with credit or debit /  tracks cash transactions\r\n  - Collects Data pertaining to items sold (when / how many / by who)\r\n  - Tracks items not sold /  thrown out\r\n    ', '2021-09-02 16:09:52.000000', '2022-07-30 16:09:52.000000', NULL, 1, 'PUB', NULL),
(6, 'Jake\'s Bar\'n\'Grill Resource Management', 'Jake\'s Bar\'n\'Grill Resource Management will be a tool developed to manage all aspects regarding the restaurant.', 'Jake\'s Bar\'n\'Grill Resource Management will be a tool developed to manage labor, purchases, food delivery, inventory, and costs.\r\n\r\nKey Features:\r\n  - Employee Scheduling, Clock in / Clock out, Payroll\r\n  - Tracks Purchases made by customer\r\n  - Tracks food delivery orders\r\n  - Tracks inventory of goods\r\n  - Tracks costs: Building, utilities, labor, food, misc\r\n  - Tracks income', '2022-02-07 16:27:30.000000', '2022-12-02 16:27:30.000000', NULL, 1, 'PUB', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_projects_project_to_announcement`
--

CREATE TABLE `djangoresourcemanagement_projects_project_to_announcement` (
  `id` bigint(20) NOT NULL,
  `projects_id` bigint(20) NOT NULL,
  `announcements_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_projects_project_to_resource`
--

CREATE TABLE `djangoresourcemanagement_projects_project_to_resource` (
  `id` bigint(20) NOT NULL,
  `projects_id` bigint(20) NOT NULL,
  `resources_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_resources`
--

CREATE TABLE `djangoresourcemanagement_resources` (
  `id` bigint(20) NOT NULL,
  `files` varchar(100) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `text` longtext,
  `link` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_resources`
--

INSERT INTO `djangoresourcemanagement_resources` (`id`, `files`, `title`, `text`, `link`) VALUES
(1, '', 'Practice Project Link', NULL, 'https://github.com/bsimmo11/django_tech_stack_project');

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_roles`
--

CREATE TABLE `djangoresourcemanagement_roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_description` varchar(100) NOT NULL,
  `long_description` longtext NOT NULL,
  `date_added` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_roles`
--

INSERT INTO `djangoresourcemanagement_roles` (`id`, `name`, `short_description`, `long_description`, `date_added`) VALUES
(1, 'Software Engineer Test', 'They do software', 'Big Software Tings', '2022-02-22 00:00:00.000000');

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_squadmembers`
--

CREATE TABLE `djangoresourcemanagement_squadmembers` (
  `id` bigint(20) NOT NULL,
  `description` varchar(150) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_added` datetime(6) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `team_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_teams`
--

CREATE TABLE `djangoresourcemanagement_teams` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `short_description` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `team_creation_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `type` varchar(3) NOT NULL,
  `leader_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_teams`
--

INSERT INTO `djangoresourcemanagement_teams` (`id`, `name`, `short_description`, `description`, `team_creation_date`, `is_active`, `type`, `leader_id`) VALUES
(1, 'Data Collection 1', 'Data Collection Team 1 specializing in the development of applications revolving around the collection of data and the tools for analysis.', '- Apps\r\n- Stores\r\n- Inventory', '2022-01-02 19:41:01.000000', 1, 'PUB', NULL),
(2, 'Data Collection 2', 'Data Collection Team 2 specializing in the development of applications revolving around the collection of data and the tools for analysis.', '- Apps\r\n- Stores\r\n- Inventory', '2022-01-24 19:44:24.000000', 1, 'PUB', NULL),
(3, 'Inventory 1', 'Inventory Team 1 specializing in the development of applications revolving around the tracking of inventory.', 'Developed applications for:\r\n- Warehouses\r\n- Stores\r\n- Restaurants', '2021-12-06 19:45:02.000000', 1, 'PUB', NULL),
(4, 'Inventory 2', 'Inventory Team 2 specializing in the development of applications revolving around the tracking of inventory.', 'Developed applications for:\r\n- Warehouses\r\n- Stores\r\n- Restaurants', '2021-12-20 19:45:02.000000', 1, 'PUB', NULL),
(5, 'App Development 1', 'App Development Team 1 specializes in the creation of apps to be sold on various play-stores. ', 'Platforms:\r\n- Pear\r\n- Droid\r\n- Mindows\r\n- Candle', '2022-02-21 19:50:26.000000', 1, 'PUB', NULL),
(6, 'App Development 2', 'App Development Team 2 specializes in the creation of apps to be sold on various play-stores. ', 'Platforms:\r\n- Pear\r\n- Droid\r\n- Mindows\r\n- Candle', '2022-02-28 19:50:26.000000', 1, 'PUB', NULL),
(7, 'Business Resources 1', 'Business Resources Team 1 specializes in the creation of applications to help small business manage day to day tasks.', 'Applications assist/ perform:\r\n- Transactions\r\n- Payroll\r\n- Inventory\r\n- Data collection of sales / cost of business', '2021-11-01 19:53:34.000000', 1, 'PUB', NULL),
(8, 'Business Resources 2', 'Business Resources Team 2 specializes in the creation of applications to help small business manage day to day tasks.', 'Applications assist/ perform:\r\n- Transactions\r\n- Payroll\r\n- Inventory\r\n- Data collection of sales / cost of business', '2022-02-14 19:53:34.000000', 1, 'PUB', NULL),
(9, 'Web Development 1', 'Web Development 1 specializes in the creation of website applications that range in many uses for a business. ', 'Websites:\r\n- Store Info\r\n- Marketing\r\n- Online store\r\n- Appointment System\r\n- Customer assistance tools', '2022-01-03 19:58:55.000000', 1, 'PUB', NULL),
(22, 'Web Development 2', 'Web Development 2 specializes in the creation of website applications that range in many uses for a business. ', 'Websites:\r\n- Store Info\r\n- Marketing\r\n- Online store\r\n- Appointment System\r\n- Customer assistance tools', '2022-01-28 19:58:55.000000', 1, 'PUB', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_teams_team_announcements`
--

CREATE TABLE `djangoresourcemanagement_teams_team_announcements` (
  `id` bigint(20) NOT NULL,
  `teams_id` bigint(20) NOT NULL,
  `announcements_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_teams_team_projects`
--

CREATE TABLE `djangoresourcemanagement_teams_team_projects` (
  `id` bigint(20) NOT NULL,
  `teams_id` bigint(20) NOT NULL,
  `projects_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_teams_team_resources`
--

CREATE TABLE `djangoresourcemanagement_teams_team_resources` (
  `id` bigint(20) NOT NULL,
  `teams_id` bigint(20) NOT NULL,
  `resources_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_techskill`
--

CREATE TABLE `djangoresourcemanagement_techskill` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `category` varchar(255) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_techskill`
--

INSERT INTO `djangoresourcemanagement_techskill` (`id`, `name`, `category`, `domain`, `description`) VALUES
(1, 'C#', 'Programming Language', NULL, 'C# Programming Language'),
(2, 'AWS Rolling Update', 'Deployment', NULL, 'Replaces previous versions of an application with new versions by replacing application infrastructure'),
(3, 'Django', 'Framework', NULL, 'Django framework manages backend and frontend connections as well as databasing'),
(4, 'HTML', 'Frontend', NULL, 'HTML Programming Language'),
(5, 'SQL', 'Database', NULL, 'SQL Language');

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_users`
--

CREATE TABLE `djangoresourcemanagement_users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `work_email` varchar(60) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `address` varchar(250) DEFAULT NULL,
  `position` varchar(200) DEFAULT NULL,
  `marital_status` varchar(150) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `hire_date` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `permission` varchar(8) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `supervisor_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_users`
--

INSERT INTO `djangoresourcemanagement_users` (`id`, `username`, `password`, `email`, `work_email`, `first_name`, `last_name`, `address`, `position`, `marital_status`, `rate`, `hire_date`, `date_joined`, `last_login`, `permission`, `is_admin`, `is_staff`, `is_superuser`, `is_active`, `supervisor_id`) VALUES
(1, 'jack123', 'pbkdf2_sha256$320000$kcoLn2xZdsWp9nBMAlavUr$5nG2szFMLS8BC2e4WrryE9NcfTbjKKKK3rvNRLpP0hI=', 'jacksemail@email.com', 'jackjohnson@workplace.com', 'Jack', 'Johnson', '1111 Longstreet Road', 'Software Developer', 'Very Single', '80000.00', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', '2022-03-26 18:21:43.098242', 'MNGR', 0, 0, 0, 1, NULL),
(2, 'jimboTheBro', 'pbkdf2_sha256$320000$kcoLn2xZdsWp9nBMAlavUr$5nG2szFMLS8BC2e4WrryE9NcfTbjKKKK3rvNRLpP0hI=', 'jimboworth@email.com', 'jimothywilliams@workplace.com', 'Jimothy', 'Williams', '1234 Roundabout Street', 'Software Developer', 'Single', '82000.00', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', '2022-03-18 17:57:43.162242', 'EMP', 0, 0, 0, 1, 1),
(3, 'marySm1th', 'pbkdf2_sha256$320000$kcoLn2xZdsWp9nBMAlavUr$5nG2szFMLS8BC2e4WrryE9NcfTbjKKKK3rvNRLpP0hI=', 'msmith@email.com', 'marysmith@workplace.com', 'Mary', 'Smith', '4444 Really Old Road', 'UX Designer', 'Married', '69000.00', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', 'EMP', 0, 0, 0, 1, 1),
(4, 'm1guelTheDude', 'pbkdf2_sha256$320000$kcoLn2xZdsWp9nBMAlavUr$5nG2szFMLS8BC2e4WrryE9NcfTbjKKKK3rvNRLpP0hI=', 'mdude@email.com', 'miguelhonduras@workplace.com', 'Miguel', 'Honduras', '5555 Sandy Street', 'Software Developer', 'Divorced', '90000.00', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', 'EMP', 0, 0, 0, 1, 1),
(5, 'carebear', 'pbkdf2_sha256$320000$kcoLn2xZdsWp9nBMAlavUr$5nG2szFMLS8BC2e4WrryE9NcfTbjKKKK3rvNRLpP0hI=', 'careb3ar@email.com', 'carrieberry@workplace.com', 'Carrie', 'Berry', '9843 Windyday Way', 'Server Maintenecne ', 'Widow', '54000.00', '2022-02-14 20:58:00.000000', '2022-02-14 20:58:00.000000', '2022-03-18 17:58:12.140284', 'EMP', 0, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_users_mentor`
--

CREATE TABLE `djangoresourcemanagement_users_mentor` (
  `id` bigint(20) NOT NULL,
  `from_users_id` bigint(20) NOT NULL,
  `to_users_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_users_user_project`
--

CREATE TABLE `djangoresourcemanagement_users_user_project` (
  `id` bigint(20) NOT NULL,
  `users_id` bigint(20) NOT NULL,
  `projects_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `djangoresourcemanagement_usertoskill`
--

CREATE TABLE `djangoresourcemanagement_usertoskill` (
  `id` bigint(20) NOT NULL,
  `date_added` datetime(6) NOT NULL,
  `skill_status` varchar(10) NOT NULL,
  `skill_status_reason` varchar(255) DEFAULT NULL,
  `date_modified_status` datetime(6) DEFAULT NULL,
  `proficiency_id` bigint(20) DEFAULT NULL,
  `projects_that_show_experience_of_skill_id` bigint(20) DEFAULT NULL,
  `skill_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `djangoresourcemanagement_usertoskill`
--

INSERT INTO `djangoresourcemanagement_usertoskill` (`id`, `date_added`, `skill_status`, `skill_status_reason`, `date_modified_status`, `proficiency_id`, `projects_that_show_experience_of_skill_id`, `skill_id`, `user_id`) VALUES
(2, '2022-03-16 00:00:00.000000', 'PEN', NULL, NULL, 3, NULL, 4, 3),
(3, '2022-03-18 17:55:08.951308', 'PEN', NULL, NULL, 2, NULL, 1, 1),
(4, '2022-03-18 17:55:08.958495', 'PEN', NULL, NULL, 3, NULL, 4, 1),
(5, '2022-03-18 17:57:43.143292', 'PEN', NULL, NULL, 2, NULL, 1, 2),
(6, '2022-03-18 17:58:12.119836', 'PEN', NULL, NULL, 3, NULL, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(7, 'djangoresourcemanagement', 'announcements'),
(8, 'djangoresourcemanagement', 'proficiencylevels'),
(9, 'djangoresourcemanagement', 'projects'),
(10, 'djangoresourcemanagement', 'resources'),
(11, 'djangoresourcemanagement', 'roles'),
(12, 'djangoresourcemanagement', 'squadmembers'),
(15, 'djangoresourcemanagement', 'teams'),
(13, 'djangoresourcemanagement', 'techskill'),
(6, 'djangoresourcemanagement', 'users'),
(14, 'djangoresourcemanagement', 'usertoskill'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'djangoresourcemanagement', '0001_initial', '2022-02-16 01:54:45.076982'),
(2, 'contenttypes', '0001_initial', '2022-02-16 01:54:45.265853'),
(3, 'admin', '0001_initial', '2022-02-16 01:54:45.863741'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-02-16 01:54:45.905071'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-02-16 01:54:45.952059'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-02-16 01:54:46.360863'),
(7, 'auth', '0001_initial', '2022-02-16 01:54:47.557142'),
(8, 'auth', '0002_alter_permission_name_max_length', '2022-02-16 01:54:47.827712'),
(9, 'auth', '0003_alter_user_email_max_length', '2022-02-16 01:54:47.853605'),
(10, 'auth', '0004_alter_user_username_opts', '2022-02-16 01:54:47.877219'),
(11, 'auth', '0005_alter_user_last_login_null', '2022-02-16 01:54:47.907113'),
(12, 'auth', '0006_require_contenttypes_0002', '2022-02-16 01:54:47.920571'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2022-02-16 01:54:47.947028'),
(14, 'auth', '0008_alter_user_username_max_length', '2022-02-16 01:54:47.975109'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2022-02-16 01:54:48.012666'),
(16, 'auth', '0010_alter_group_name_max_length', '2022-02-16 01:54:48.265063'),
(17, 'auth', '0011_update_proxy_permissions', '2022-02-16 01:54:48.324670'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2022-02-16 01:54:48.341421'),
(19, 'djangoresourcemanagement', '0002_alter_usertoskill_date_modified_status_and_more', '2022-02-16 01:54:48.959149'),
(20, 'djangoresourcemanagement', '0003_alter_users_mentor_alter_users_supervisor', '2022-02-16 01:54:50.054087'),
(21, 'djangoresourcemanagement', '0004_alter_users_mentor_alter_users_supervisor', '2022-02-16 01:54:51.147531'),
(22, 'djangoresourcemanagement', '0005_alter_users_rate', '2022-02-16 01:54:51.529293'),
(23, 'sessions', '0001_initial', '2022-02-16 01:54:51.729101'),
(24, 'djangoresourcemanagement', '0006_alter_users_supervisor', '2022-02-16 01:57:25.930748');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('dwtg7bgp8521d0rjvq0gzqmcbzql9jel', '.eJxVjL0OwiAYAN-F2RCgpYCje5-BfD8gVUOT0k7GdzckHXS9u9xbRDj2Eo-WtriwuAotLr8MgZ6pdsEPqPdV0lr3bUHZE3naJueV0-t2tn-DAq30LTEyZeV4GhKq4NCgDcGR096A8WizZiJQeSI3wBgCG6OTHQNaT9qJzxcBxDg2:1nYB2l:b5GwMT_2RDKuz3IGIlkZifQiRQJvhnDJCe8MkgFSDuo', '2022-04-09 18:21:43.112205'),
('h36me6ekqtyn7r09j24pl0qzxtwioy2t', '.eJxVjL0OwiAYAN-F2RCgpYCje5-BfD8gVUOT0k7GdzckHXS9u9xbRDj2Eo-WtriwuAotLr8MgZ6pdsEPqPdV0lr3bUHZE3naJueV0-t2tn-DAq30LTEyZeV4GhKq4NCgDcGR096A8WizZiJQeSI3wBgCG6OTHQNaT9qJzxcBxDg2:1nMgxV:z0VMi0m8v3bMQJtoD3RhGFRawmtDeKeZTbxoqiXsxEc', '2022-03-09 02:00:49.934854');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `djangoresourcemanagement_announcements`
--
ALTER TABLE `djangoresourcemanagement_announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `djangoresourcemanage_author_id_c07f0e81_fk_djangores` (`author_id`);

--
-- Indexes for table `djangoresourcemanagement_announcements_announcement_to_resource`
--
ALTER TABLE `djangoresourcemanagement_announcements_announcement_to_resource`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_announcements_id_resourc_05587c2e_uniq` (`announcements_id`,`resources_id`),
  ADD KEY `djangoresourcemanage_resources_id_c20b1998_fk_djangores` (`resources_id`);

--
-- Indexes for table `djangoresourcemanagement_proficiencylevels`
--
ALTER TABLE `djangoresourcemanagement_proficiencylevels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `djangoresourcemanagement_projects`
--
ALTER TABLE `djangoresourcemanagement_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `djangoresourcemanage_project_owner_id_4ece2fee_fk_djangores` (`project_owner_id`);

--
-- Indexes for table `djangoresourcemanagement_projects_project_to_announcement`
--
ALTER TABLE `djangoresourcemanagement_projects_project_to_announcement`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_projects_id_announcement_fac01377_uniq` (`projects_id`,`announcements_id`),
  ADD KEY `djangoresourcemanage_announcements_id_f56d1234_fk_djangores` (`announcements_id`);

--
-- Indexes for table `djangoresourcemanagement_projects_project_to_resource`
--
ALTER TABLE `djangoresourcemanagement_projects_project_to_resource`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_projects_id_resources_id_b7de00cf_uniq` (`projects_id`,`resources_id`),
  ADD KEY `djangoresourcemanage_resources_id_80612850_fk_djangores` (`resources_id`);

--
-- Indexes for table `djangoresourcemanagement_resources`
--
ALTER TABLE `djangoresourcemanagement_resources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `djangoresourcemanagement_roles`
--
ALTER TABLE `djangoresourcemanagement_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `djangoresourcemanagement_squadmembers`
--
ALTER TABLE `djangoresourcemanagement_squadmembers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `djangoresourcemanage_team_id_e58134ae_fk_djangores` (`team_id`),
  ADD KEY `djangoresourcemanage_user_id_73e03125_fk_djangores` (`user_id`),
  ADD KEY `djangoresourcemanage_role_id_264b99e4_fk_djangores` (`role_id`);

--
-- Indexes for table `djangoresourcemanagement_teams`
--
ALTER TABLE `djangoresourcemanagement_teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `djangoresourcemanage_leader_id_d1bceeca_fk_djangores` (`leader_id`);

--
-- Indexes for table `djangoresourcemanagement_teams_team_announcements`
--
ALTER TABLE `djangoresourcemanagement_teams_team_announcements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_teams_id_announcements_i_04bb7b79_uniq` (`teams_id`,`announcements_id`),
  ADD KEY `djangoresourcemanage_announcements_id_d1ee5ae5_fk_djangores` (`announcements_id`);

--
-- Indexes for table `djangoresourcemanagement_teams_team_projects`
--
ALTER TABLE `djangoresourcemanagement_teams_team_projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_teams_id_projects_id_7237ed69_uniq` (`teams_id`,`projects_id`),
  ADD KEY `djangoresourcemanage_projects_id_4df2b020_fk_djangores` (`projects_id`);

--
-- Indexes for table `djangoresourcemanagement_teams_team_resources`
--
ALTER TABLE `djangoresourcemanagement_teams_team_resources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_teams_id_resources_id_e3d0901b_uniq` (`teams_id`,`resources_id`),
  ADD KEY `djangoresourcemanage_resources_id_cb337fd4_fk_djangores` (`resources_id`);

--
-- Indexes for table `djangoresourcemanagement_techskill`
--
ALTER TABLE `djangoresourcemanagement_techskill`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `djangoresourcemanagement_users`
--
ALTER TABLE `djangoresourcemanagement_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `work_email` (`work_email`),
  ADD KEY `djangoresourcemanage_supervisor_id_e41ad95c_fk_djangores` (`supervisor_id`);

--
-- Indexes for table `djangoresourcemanagement_users_mentor`
--
ALTER TABLE `djangoresourcemanagement_users_mentor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_from_users_id_to_users_i_82a4cb83_uniq` (`from_users_id`,`to_users_id`),
  ADD KEY `djangoresourcemanage_to_users_id_86aaf19e_fk_djangores` (`to_users_id`);

--
-- Indexes for table `djangoresourcemanagement_users_user_project`
--
ALTER TABLE `djangoresourcemanagement_users_user_project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `djangoresourcemanagement_users_id_projects_id_292c7ca7_uniq` (`users_id`,`projects_id`),
  ADD KEY `djangoresourcemanage_projects_id_9dba431d_fk_djangores` (`projects_id`);

--
-- Indexes for table `djangoresourcemanagement_usertoskill`
--
ALTER TABLE `djangoresourcemanagement_usertoskill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `djangoresourcemanage_proficiency_id_837af821_fk_djangores` (`proficiency_id`),
  ADD KEY `djangoresourcemanage_projects_that_show_e_d101f576_fk_djangores` (`projects_that_show_experience_of_skill_id`),
  ADD KEY `djangoresourcemanage_skill_id_41a84fba_fk_djangores` (`skill_id`),
  ADD KEY `djangoresourcemanage_user_id_63020f38_fk_djangores` (`user_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_djangores` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_announcements`
--
ALTER TABLE `djangoresourcemanagement_announcements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_announcements_announcement_to_resource`
--
ALTER TABLE `djangoresourcemanagement_announcements_announcement_to_resource`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_proficiencylevels`
--
ALTER TABLE `djangoresourcemanagement_proficiencylevels`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_projects`
--
ALTER TABLE `djangoresourcemanagement_projects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_projects_project_to_announcement`
--
ALTER TABLE `djangoresourcemanagement_projects_project_to_announcement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_projects_project_to_resource`
--
ALTER TABLE `djangoresourcemanagement_projects_project_to_resource`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_resources`
--
ALTER TABLE `djangoresourcemanagement_resources`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_roles`
--
ALTER TABLE `djangoresourcemanagement_roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_squadmembers`
--
ALTER TABLE `djangoresourcemanagement_squadmembers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_teams`
--
ALTER TABLE `djangoresourcemanagement_teams`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_teams_team_announcements`
--
ALTER TABLE `djangoresourcemanagement_teams_team_announcements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_teams_team_projects`
--
ALTER TABLE `djangoresourcemanagement_teams_team_projects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_teams_team_resources`
--
ALTER TABLE `djangoresourcemanagement_teams_team_resources`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_techskill`
--
ALTER TABLE `djangoresourcemanagement_techskill`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_users`
--
ALTER TABLE `djangoresourcemanagement_users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_users_mentor`
--
ALTER TABLE `djangoresourcemanagement_users_mentor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_users_user_project`
--
ALTER TABLE `djangoresourcemanagement_users_user_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `djangoresourcemanagement_usertoskill`
--
ALTER TABLE `djangoresourcemanagement_usertoskill`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `djangoresourcemanagement_announcements`
--
ALTER TABLE `djangoresourcemanagement_announcements`
  ADD CONSTRAINT `djangoresourcemanage_author_id_c07f0e81_fk_djangores` FOREIGN KEY (`author_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_announcements_announcement_to_resource`
--
ALTER TABLE `djangoresourcemanagement_announcements_announcement_to_resource`
  ADD CONSTRAINT `djangoresourcemanage_announcements_id_ee8d94a8_fk_djangores` FOREIGN KEY (`announcements_id`) REFERENCES `djangoresourcemanagement_announcements` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_resources_id_c20b1998_fk_djangores` FOREIGN KEY (`resources_id`) REFERENCES `djangoresourcemanagement_resources` (`id`);

--
-- Constraints for table `djangoresourcemanagement_projects`
--
ALTER TABLE `djangoresourcemanagement_projects`
  ADD CONSTRAINT `djangoresourcemanage_project_owner_id_4ece2fee_fk_djangores` FOREIGN KEY (`project_owner_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_projects_project_to_announcement`
--
ALTER TABLE `djangoresourcemanagement_projects_project_to_announcement`
  ADD CONSTRAINT `djangoresourcemanage_announcements_id_f56d1234_fk_djangores` FOREIGN KEY (`announcements_id`) REFERENCES `djangoresourcemanagement_announcements` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_projects_id_39777082_fk_djangores` FOREIGN KEY (`projects_id`) REFERENCES `djangoresourcemanagement_projects` (`id`);

--
-- Constraints for table `djangoresourcemanagement_projects_project_to_resource`
--
ALTER TABLE `djangoresourcemanagement_projects_project_to_resource`
  ADD CONSTRAINT `djangoresourcemanage_projects_id_c6f38bec_fk_djangores` FOREIGN KEY (`projects_id`) REFERENCES `djangoresourcemanagement_projects` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_resources_id_80612850_fk_djangores` FOREIGN KEY (`resources_id`) REFERENCES `djangoresourcemanagement_resources` (`id`);

--
-- Constraints for table `djangoresourcemanagement_squadmembers`
--
ALTER TABLE `djangoresourcemanagement_squadmembers`
  ADD CONSTRAINT `djangoresourcemanage_role_id_264b99e4_fk_djangores` FOREIGN KEY (`role_id`) REFERENCES `djangoresourcemanagement_roles` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_team_id_e58134ae_fk_djangores` FOREIGN KEY (`team_id`) REFERENCES `djangoresourcemanagement_teams` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_user_id_73e03125_fk_djangores` FOREIGN KEY (`user_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_teams`
--
ALTER TABLE `djangoresourcemanagement_teams`
  ADD CONSTRAINT `djangoresourcemanage_leader_id_d1bceeca_fk_djangores` FOREIGN KEY (`leader_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_teams_team_announcements`
--
ALTER TABLE `djangoresourcemanagement_teams_team_announcements`
  ADD CONSTRAINT `djangoresourcemanage_announcements_id_d1ee5ae5_fk_djangores` FOREIGN KEY (`announcements_id`) REFERENCES `djangoresourcemanagement_announcements` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_teams_id_0f7041a3_fk_djangores` FOREIGN KEY (`teams_id`) REFERENCES `djangoresourcemanagement_teams` (`id`);

--
-- Constraints for table `djangoresourcemanagement_teams_team_projects`
--
ALTER TABLE `djangoresourcemanagement_teams_team_projects`
  ADD CONSTRAINT `djangoresourcemanage_projects_id_4df2b020_fk_djangores` FOREIGN KEY (`projects_id`) REFERENCES `djangoresourcemanagement_projects` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_teams_id_0b2cf500_fk_djangores` FOREIGN KEY (`teams_id`) REFERENCES `djangoresourcemanagement_teams` (`id`);

--
-- Constraints for table `djangoresourcemanagement_teams_team_resources`
--
ALTER TABLE `djangoresourcemanagement_teams_team_resources`
  ADD CONSTRAINT `djangoresourcemanage_resources_id_cb337fd4_fk_djangores` FOREIGN KEY (`resources_id`) REFERENCES `djangoresourcemanagement_resources` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_teams_id_289d0271_fk_djangores` FOREIGN KEY (`teams_id`) REFERENCES `djangoresourcemanagement_teams` (`id`);

--
-- Constraints for table `djangoresourcemanagement_users`
--
ALTER TABLE `djangoresourcemanagement_users`
  ADD CONSTRAINT `djangoresourcemanage_supervisor_id_e41ad95c_fk_djangores` FOREIGN KEY (`supervisor_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_users_mentor`
--
ALTER TABLE `djangoresourcemanagement_users_mentor`
  ADD CONSTRAINT `djangoresourcemanage_from_users_id_47568fdc_fk_djangores` FOREIGN KEY (`from_users_id`) REFERENCES `djangoresourcemanagement_users` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_to_users_id_86aaf19e_fk_djangores` FOREIGN KEY (`to_users_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_users_user_project`
--
ALTER TABLE `djangoresourcemanagement_users_user_project`
  ADD CONSTRAINT `djangoresourcemanage_projects_id_9dba431d_fk_djangores` FOREIGN KEY (`projects_id`) REFERENCES `djangoresourcemanagement_projects` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_users_id_c9f33144_fk_djangores` FOREIGN KEY (`users_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `djangoresourcemanagement_usertoskill`
--
ALTER TABLE `djangoresourcemanagement_usertoskill`
  ADD CONSTRAINT `djangoresourcemanage_proficiency_id_837af821_fk_djangores` FOREIGN KEY (`proficiency_id`) REFERENCES `djangoresourcemanagement_proficiencylevels` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_projects_that_show_e_d101f576_fk_djangores` FOREIGN KEY (`projects_that_show_experience_of_skill_id`) REFERENCES `djangoresourcemanagement_projects` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_skill_id_41a84fba_fk_djangores` FOREIGN KEY (`skill_id`) REFERENCES `djangoresourcemanagement_techskill` (`id`),
  ADD CONSTRAINT `djangoresourcemanage_user_id_63020f38_fk_djangores` FOREIGN KEY (`user_id`) REFERENCES `djangoresourcemanagement_users` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_djangores` FOREIGN KEY (`user_id`) REFERENCES `djangoresourcemanagement_users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
