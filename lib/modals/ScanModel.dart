//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

class HistoryModel {
  int? id;
  String? imageUrl;
  String? type;
  String? qrType;
  String? title;
  String? firstName;
  String? eventName;
  String? link;
  String? website;
  String? wifiName;
  String? password;
  String? protocol;
  String? ishidden;
  String? startDateTime;
  String? endDateTime;
  String? eventLocation;
  String? eventDescription;
  String? lastName;
  String? company;
  String? job;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? country;
  String? industry;
  String? createdAt;

  HistoryModel({
    this.id,
    this.imageUrl,
    this.type,
    this.qrType,
    this.website,
    this.firstName,
    this.title,
    this.wifiName,
    this.link,
    this.password,
    this.protocol,
    this.ishidden,
    this.startDateTime,
    this.endDateTime,
    this.eventLocation,
    this.eventDescription,
    this.lastName,
    this.company,
    this.job,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.email,
    this.industry,
    this.createdAt,
  });

  // DateTime get dateTime => null;

  static Map<String, dynamic> toMap(HistoryModel history) => {
        // 'id': history.id ?? '',
        'type': history.type ?? '',
        'title': history.title ?? '',
        'qr_type': history.qrType ?? '',
        'first_name': history.firstName ?? '',
        'last_name': history.lastName ?? '',
        'wifi_name': history.wifiName ?? '',
        'image_url': history.imageUrl ?? '',
        'link': history.link ?? '',
        'password': history.password ?? '',
        'protocol': history.protocol ?? '',
        'is_hidden': (history.ishidden) ?? '',
        'start_datetime': history.startDateTime ?? '',
        'end_datetime': history.endDateTime ?? '',
        'event_location': history.eventLocation ?? '',
        'event_description': history.eventDescription ?? '',
        'job': history.job ?? '',
        'industry': history.industry ?? '',
        'email': history.email ?? '',
        'contact_number': history.phone ?? '',
        'company_name': history.company ?? '',
        'website': history.website ?? '',
        'address': history.address ?? '',
        'country': history.country ?? '',
        'city': history.city ?? '',
        'created_at': history.createdAt ??
            DateTime.now().millisecondsSinceEpoch.toString(),
      };

  static HistoryModel fromMap(Map<String, dynamic> map) => HistoryModel(
        id: map['id'] ?? '',
        type: map['type'] ?? '',
        qrType: map['qr_type'] ?? '',
        title: map['title'] ?? '',
        firstName: map['first_name'] ?? '',
        lastName: map['last_name'] ?? '',
        wifiName: map['wifi_name'] ?? '',
        imageUrl: map['image_url'] ?? '',
        link: map['link'] ?? '',
        password: map['password'] ?? '',
        protocol: map['protocol'] ?? '',
        ishidden: map['is_hidden'] ?? '',
        startDateTime: map['start_datetime'] ?? '',
        endDateTime: map['end_datetime'] ?? '',
        eventLocation: map['event_location'] ?? '',
        eventDescription: map['event_description'] ?? '',
        job: map['job'] ?? '',
        industry: map['industry'] ?? '',
        email: map['email'] ?? '',
        phone: map['contact_number'] ?? '',
        company: map['company_name'] ?? '',
        website: map['website'] ?? '',
        address: map['address'],
        country: map['country'] ?? '',
        city: map['city'] ?? '',
        createdAt: map['created_at'] ?? DateTime.now().millisecondsSinceEpoch,
      );



      }
