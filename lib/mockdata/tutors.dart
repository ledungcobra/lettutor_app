import 'package:lettutor_app/models/course_preview.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/tutor_detail.dart';

List<String> tutorFilters = [
  "All",
  "English for kids",
  "Business English",
  "Conversational",
  "STARTERS",
  "MOVERS",
  "FLYERS",
  "KET",
  "PET",
  "IELTS",
  "TOEFL",
  "TOEIC",
];

class Nationality {
  String display;
  String value;

  Nationality(this.display, this.value);
}

List<Nationality> nationalities = [
  Nationality("Gia sư nước ngoài", "oversea"),
  Nationality("Gia sư Viêt Nam", "vietnamese"),
  Nationality("Gia sư Bản Ngữ", "native"),
];

List<Tutor> listTutors = [
  Tutor(
    id: "1",
    name: "April corpuz",
    language: ["English"],
    specialties: [
      "English for Business",
      "Conversational",
      "English for kids",
      "STARTERS",
      "MOVERS",
    ],
    avatar:
        "https://api.app.lettutor.com/avatar/635f59d8-15d2-4e17-a1b1-bf397ffb7ec9avatar1662530466338.jpg",
    rating: 4.5,
    interests:
        "Cooking, Mingling with kids, Watch my small retail store, Travelling",
    description:
        "Hello there! I am an Industrial Engineer in the profession but chose to do online teaching because I love to meet different learners. I am an outgoing person and I have this passion for dealing with different people and seeing them progress with my help as their teacher. In fact, making friends is one of my best skills. I am very good at adapting to new environments and new situations. I am very friendly and can easily get along well with everyone. I have obtained a 120-Hour TEFL Certificate. I get a variety of teaching techniques. I know that there are fast and not so fast learners. So don't worry, I will be with you every step of the way going at your own pace. Let's practice what you already know and add something new each day. With my skills and experiences, I can assure you that I can provide adequate English learning effectively and efficiently. Together, let's make English learning fun.",
  ),
  Tutor(
    id: "2",
    name: "Hannah Nguyen",
    language: ["English"],
    specialties: [
      "Conversational",
      "English for kids",
      "STARTERS",
      "MOVERS",
      "TOEIC",
      "FLYERS",
    ],
    avatar:
        "https://api.app.lettutor.com/avatar/635f59d8-15d2-4e17-a1b1-bf397ffb7ec9avatar1662530466338.jpg",
    rating: 4.5,
    interests: "Finance, gardening, travelling",
    description:
        "I have been teaching English as a second language for kids, teenagers and adults for 5 years. I can help you gain a stronger foundation in English before furthering your studies. I'm patient, will speak slowly and clearly so don't hesitate to ask for good understanding.",
  ),
  Tutor(
    id: "3",
    name: "Nhi Lam",
    language: ["English"],
    specialties: [
      "Conversational",
      "English for kids",
      "IELTS",
    ],
    avatar:
        "https://api.app.lettutor.com/avatar/56b20f11-9a07-48d0-97f4-245d031be33davatar1662521431656.jpg",
    rating: 4.5,
    interests: "Finance, gardening, travelling",
    description:
        "Hi, I am teacher Nhi. I have been teaching English for 2 years. I used to study abroad in Sydney for 7 years. During my time as an overseas student, I had spoken with many people from diverse cultural backgrounds; therefore, I have strong listening and speaking skills. I love teaching English and I will devote to helping you improve your English skills if you book my class. I am also patient and understanding because I know for many people, English is a tough language to master. In my class, I will help you correct your pronunciation and deliver the lessons in a way that is easy for you to understand. If you book my class, you will have many chances to practice your speaking skills and also improve your pronunciation and grammatical knowledge. Besides that, if you need me to, I will share my personal tips to study English more effectively with you and show you the importance of having fun and practice while learning English. As an English teacher, I constantly update my English knowledge to better serve my career and students.",
  ),
];

List<TutorDetail> listTutorDetails = [
  TutorDetail(
      id: "1",
      name: "April corpuz",
      language: ["English"],
      specialties: [
        "English for Business",
        "Conversational",
        "English for kids",
        "STARTERS",
        "MOVERS",
      ],
      avatar:
          "https://api.app.lettutor.com/avatar/635f59d8-15d2-4e17-a1b1-bf397ffb7ec9avatar1662530466338.jpg",
      rating: 4.5,
      interests:
          "Cooking, Mingling with kids, Watch my small retail store, Travelling",
      description:
          "Hello there! I am an Industrial Engineer in the profession but chose to do online teaching because I love to meet different learners. I am an outgoing person and I have this passion for dealing with different people and seeing them progress with my help as their teacher. In fact, making friends is one of my best skills. I am very good at adapting to new environments and new situations. I am very friendly and can easily get along well with everyone. I have obtained a 120-Hour TEFL Certificate. I get a variety of teaching techniques. I know that there are fast and not so fast learners. So don't worry, I will be with you every step of the way going at your own pace. Let's practice what you already know and add something new each day. With my skills and experiences, I can assure you that I can provide adequate English learning effectively and efficiently. Together, let's make English learning fun.",
      isNative: false,
      education: "",
      video: "",
      courses: [
        CoursePreview(id: "1234", name: "Classic - Pre Intermediate 1"),
        CoursePreview(id: "1234", name: "Classic - Elementary 3"),
        CoursePreview(id: "1234", name: "Classic - Elementary 1"),
        CoursePreview(id: "1234", name: "Classic - Elementary 1"),
        CoursePreview(id: "1234", name: "Classic - Elementary 4"),
        CoursePreview(id: "1234", name: "Movies and Television (New)"),
        CoursePreview(id: "1234", name: "Classic - Elementary 2"),
        CoursePreview(id: "1234", name: "Classic - Beginner (CEFR A0)"),

      ]),
  TutorDetail(
      id: "2",
      name: "Hannah Nguyen",
      language: ["English"],
      specialties: [
        "Conversational",
        "English for kids",
        "STARTERS",
        "MOVERS",
        "TOEIC",
        "FLYERS",
      ],
      avatar:
          "https://api.app.lettutor.com/avatar/635f59d8-15d2-4e17-a1b1-bf397ffb7ec9avatar1662530466338.jpg",
      rating: 4.5,
      interests: "Finance, gardening, travelling",
      description:
          "I have been teaching English as a second language for kids, teenagers and adults for 5 years. I can help you gain a stronger foundation in English before furthering your studies. I'm patient, will speak slowly and clearly so don't hesitate to ask for good understanding.",
      isNative: false,
      education: "",
      video: ""),
  TutorDetail(
      id: "3",
      name: "Nhi Lam",
      language: ["English"],
      specialties: [
        "Conversational",
        "English for kids",
        "IELTS",
      ],
      avatar:
          "https://api.app.lettutor.com/avatar/56b20f11-9a07-48d0-97f4-245d031be33davatar1662521431656.jpg",
      rating: 4.5,
      interests: "Finance, gardening, travelling",
      description:
          "Hi, I am teacher Nhi. I have been teaching English for 2 years. I used to study abroad in Sydney for 7 years. During my time as an overseas student, I had spoken with many people from diverse cultural backgrounds; therefore, I have strong listening and speaking skills. I love teaching English and I will devote to helping you improve your English skills if you book my class. I am also patient and understanding because I know for many people, English is a tough language to master. In my class, I will help you correct your pronunciation and deliver the lessons in a way that is easy for you to understand. If you book my class, you will have many chances to practice your speaking skills and also improve your pronunciation and grammatical knowledge. Besides that, if you need me to, I will share my personal tips to study English more effectively with you and show you the importance of having fun and practice while learning English. As an English teacher, I constantly update my English knowledge to better serve my career and students.",
      isNative: false,
      education: "",
      video: ""),
];
