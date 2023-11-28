# frozen_string_literal: true

malaysia = Common::Country.find_or_create_by(name: 'Malaysia')

# States and Cities data
states_and_cities = {
  'Johor' => [
    'Johor Bahru', 'Tebrau', 'Pasir Gudang', 'Bukit Indah', 'Skudai', 'Kluang', 'Batu Pahat', 'Muar',
    'Ulu Tiram', 'Senai', 'Segamat', 'Kulai', 'Kota Tinggi', 'Pontian Kechil', 'Tangkak', 'Bukit Bakri',
    'Yong Peng', 'Pekan Nenas', 'Labis', 'Mersing', 'Simpang Renggam', 'Parit Raja', 'Kelapa Sawit', 'Buloh Kasap', 'Chaah'
  ],
  'Kedah' => [
    'Sungai Petani', 'Alor Setar', 'Kulim', 'Jitra / Kubang Pasu', 'Baling', 'Pendang', 'Langkawi', 'Yan',
    'Sik', 'Kuala Nerang', 'Pokok Sena', 'Bandar Baharu'
  ],
  'Kelantan' => [
    'Kota Bharu', 'Pangkal Kalong', 'Tanah Merah', 'Peringat', 'Wakaf Baru', 'Kadok', 'Pasir Mas', 'Gua Musang', 'Kuala Krai', 'Tumpat'
  ],
  'Melaka' => [
    'Bandaraya Melaka', 'Bukit Baru', 'Ayer Keroh', 'Klebang', 'Masjid Tanah', 'Sungai Udang', 'Batu Berendam', 'Alor Gajah',
    'Bukit Rambai', 'Ayer Molek', 'Bemban', 'Kuala Sungai Baru', 'Pulau Sebang', 'Jasin'
  ],
  'Negeri Sembilan' => [
    'Seremban', 'Port Dickson', 'Nilai', 'Bahau', 'Tampin', 'Kuala Pilah'
  ],
  'Pahang' => [
    'Kuantan', 'Temerloh', 'Bentong', 'Mentakab', 'Raub', 'Jerantut', 'Pekan', 'Kuala Lipis', 'Bandar Jengka', 'Bukit Tinggi'
  ],
  'Perak' => [
    'Ipoh', 'Taiping', 'Sitiawan', 'Simpang Empat', 'Teluk Intan', 'Batu Gajah', 'Lumut', 'Kampung Koh', 'Kuala Kangsar',
    'Sungai Siput Utara', 'Tapah', 'Bidor', 'Parit Buntar', 'Ayer Tawar', 'Bagan Serai', 'Tanjung Malim', 'Lawan Kuda Baharu',
    'Pantai Remis', 'Kampar'
  ],
  'Perlis' => [
    'Kangar', 'Kuala Perlis'
  ],
  'Pulau Pinang' => [
    'Bukit Mertajam', 'Georgetown', 'Sungai Ara', 'Gelugor', 'Ayer Itam', 'Butterworth', 'Perai', 'Nibong Tebal',
    'Permatang Kucing', 'Tanjung Tokong', 'Kepala Batas', 'Tanjung Bungah', 'Juru'
  ],
  'Sabah' => [
    'Kota Kinabalu', 'Sandakan', 'Tawau', 'Lahad Datu', 'Keningau', 'Putatan', 'Donggongon', 'Semporna', 'Kudat',
    'Kunak', 'Papar', 'Ranau', 'Beaufort', 'Kinarut', 'Kota Belud'
  ],
  'Sarawak' => [
    'Kuching', 'Miri', 'Sibu', 'Bintulu', 'Limbang', 'Sarikei', 'Sri Aman', 'Kapit', 'Batu Delapan Bazaar', 'Kota Samarahan'
  ],
  'Selangor' => [
    'Subang Jaya', 'Klang', 'Ampang Jaya', 'Shah Alam', 'Petaling Jaya', 'Cheras', 'Kajang', 'Selayang Baru',
    'Rawang', 'Taman Greenwood', 'Semenyih', 'Banting', 'Balakong', 'Gombak Setia', 'Kuala Selangor', 'Serendah',
    'Bukit Beruntung', 'Pengkalan Kundang', 'Jenjarom', 'Sungai Besar', 'Batu Arang', 'Tanjung Sepat', 'Kuang',
    'Kuala Kubu Baharu', 'Batang Berjuntai', 'Bandar Baru Salak Tinggi', 'Sekinchan', 'Sabak', 'Tanjung Karang', 'Beranang',
    'Sungai Pelek', 'Sepang'
  ],
  'Terengganu' => [
    'Kuala Terengganu', 'Chukai', 'Dungun', 'Kerteh', 'Kuala Berang', 'Marang', 'Paka', 'Jerteh'
  ],
  'Wilayah Persekutuan' => [
    'Kuala Lumpur', 'Labuan', 'Putrajaya'
  ]
}

# Loop through the states_and_cities hash and create records
states_and_cities.each do |state_name, cities|
  state = malaysia.states.find_or_create_by(name: state_name)
  cities.each do |city_name|
    state.cities.find_or_create_by(name: city_name)
  end
end

banks_data = [
  'Affin Bank Berhad',
  'Alliance Bank Malaysia Berhad',
  'AmBank (M) Berhad',
  'BNP Paribas Malaysia Berhad',
  'Bangkok Bank Berhad',
  'Bank of America Malaysia Berhad',
  'Bank of China (Malaysia) Berhad',
  'Bank of Tokyo-Mitsubishi UFJ (Malaysia) Berhad',
  'CIMB Bank Berhad',
  'China Construction Bank (Malaysia) Berhad',
  'Citibank Berhad',
  'Deutsche Bank (Malaysia) Berhad',
  'HSBC Bank Malaysia Berhad',
  'Hong Leong Bank Berhad',
  'India International Bank (Malaysia) Berhad',
  'Industrial and Commercial Bank of China (Malaysia) Berhad',
  'J.P. Morgan Chase Bank Berhad',
  'Malayan Banking Berhad (Maybank)',
  'Mizuho Bank (Malaysia) Berhad',
  'National Bank of Abu Dhabi Malaysia Berhad',
  'OCBC Bank (Malaysia) Berhad',
  'Public Bank Berhad',
  'RHB Bank Berhad',
  'Standard Chartered Bank Malaysia Berhad',
  'Sumitomo Mitsui Banking Corporation Malaysia Berhad',
  'The Bank of Nova Scotia Berhad',
  'United Overseas Bank (Malaysia) Bhd.'
]

# Seed the banks table
banks_data.each do |bank_name|
  Common::Bank.find_or_create_by(name: bank_name)
end

admin = Admin.find_or_initialize_by(email: Rails.application.credentials[:owner])

if admin.new_record?
  admin.password = Devise.friendly_token[0, 20]
  admin.password_confirmation = admin.password
  admin.skip_confirmation!

  admin.invite! if admin.save
end

events_data = [
  { name: "New Year's Day", date: Date.new(2023, 1, 1), description: 'National except Johor, Kedah, Kelantan, Perlis & Terengganu' },
  { name: 'New Year Holiday', date: Date.new(2023, 1, 2), description: 'National except Johor, Kedah, Kelantan & Terengganu' },
  { name: "YDPB Negeri Sembilan's Birthday", date: Date.new(2023, 1, 14), description: 'Negeri Sembilan' },
  { name: 'Chinese New Year', date: Date.new(2023, 1, 22), description: 'National' },
  { name: 'Chinese New Year Holiday', date: Date.new(2023, 1, 23), description: 'National' },
  { name: 'Chinese New Year Holiday', date: Date.new(2023, 1, 24), description: 'National except Johor, Kedah, Kelantan & Terengganu' },
  { name: 'Federal Territory Day', date: Date.new(2023, 2, 1), description: 'Kuala Lumpur, Labuan & Putrajaya' },
  { name: 'Thaipusam', date: Date.new(2023, 2, 5), description: 'Johor, Kuala Lumpur, Negeri Sembilan, Penang, Perak, Putrajaya & Selangor' },
  { name: 'Thaipusam Holiday', date: Date.new(2023, 2, 6), description: 'Kuala Lumpur, Negeri Sembilan, Penang, Perak, Putrajaya & Selangor' },
  { name: 'Israk and Mikraj', date: Date.new(2023, 2, 18), description: 'Kedah, Negeri Sembilan, Perlis & Terengganu' },
  { name: 'Israk and Mikraj Holiday', date: Date.new(2023, 2, 19), description: 'Terengganu' },
  { name: 'Installation of Sultan Terengganu', date: Date.new(2023, 3, 4), description: 'Terengganu' },
  { name: 'Installation of Sultan Terengganu Holiday', date: Date.new(2023, 3, 5), description: 'Terengganu' },
  { name: 'Awal Ramadan', date: Date.new(2023, 3, 23), description: 'Johor, Kedah & Melaka' },
  { name: "Sultan of Johor's Birthday", date: Date.new(2023, 3, 23), description: 'Johor' },
  { name: 'Good Friday', date: Date.new(2023, 4, 7), description: 'Sabah & Sarawak' },
  { name: 'Nuzul Al-Quran', date: Date.new(2023, 4, 8), description: 'National except Johor, Kedah, Melaka, Negeri Sembilan, Sabah & Sarawak' },
  { name: 'Nuzul Al-Quran Holiday', date: Date.new(2023, 4, 9), description: 'Kelantan & Terengganu' },
  { name: 'Declaration of Melaka as a Historical City', date: Date.new(2023, 4, 15), description: 'Melaka' },
  { name: 'Hari Raya Aidilfitri Holiday', date: Date.new(2023, 4, 21), description: 'National' },
  { name: 'Hari Raya Aidilfitri', date: Date.new(2023, 4, 22), description: 'National' },
  { name: 'Hari Raya Aidilfitri Holiday', date: Date.new(2023, 4, 23), description: 'National' },
  { name: 'Hari Raya Aidilfitri Holiday', date: Date.new(2023, 4, 24), description: 'National' },
  { name: "Sultan of Terengganu's Birthday", date: Date.new(2023, 4, 26), description: 'Terengganu' },
  { name: 'Labour Day', date: Date.new(2023, 5, 1), description: 'National' },
  { name: 'Wesak Day', date: Date.new(2023, 5, 4), description: 'National' },
  { name: "Raja Perlis' Birthday", date: Date.new(2023, 5, 17), description: 'Perlis' },
  { name: 'Hari Hol Pahang', date: Date.new(2023, 5, 22), description: 'Pahang' },
  { name: 'Harvest Festival', date: Date.new(2023, 5, 30), description: 'Labuan & Sabah' },
  { name: 'Harvest Festival Holiday', date: Date.new(2023, 5, 31), description: 'Labuan & Sabah' },
  { name: 'Hari Gawai', date: Date.new(2023, 6, 1), description: 'Sarawak' },
  { name: 'Hari Gawai Holiday', date: Date.new(2023, 6, 2), description: 'Sarawak' },
  { name: "Agong's Birthday", date: Date.new(2023, 6, 5), description: 'National' },
  { name: "Sultan of Kedah's Birthday", date: Date.new(2023, 6, 18), description: 'Kedah' },
  { name: 'Arafat Day', date: Date.new(2023, 6, 28), description: 'Kelantan & Terengganu' },
  { name: 'Hari Raya Haji', date: Date.new(2023, 6, 29), description: 'National' },
  { name: 'Hari Raya Haji Holiday', date: Date.new(2023, 6, 30), description: 'Kedah, Kelantan, Perlis & Terengganu' },
  { name: 'Georgetown World Heritage City Day', date: Date.new(2023, 7, 7), description: 'Penang' },
  { name: "Penang Governor's Birthday", date: Date.new(2023, 7, 8), description: 'Penang' },
  { name: 'Awal Muharram', date: Date.new(2023, 7, 19), description: 'National' },
  { name: 'Sarawak Day', date: Date.new(2023, 7, 22), description: 'Sarawak' },
  { name: "Sultan of Pahang's Birthday", date: Date.new(2023, 7, 30), description: 'Pahang' },
  { name: "Sultan of Pahang's Birthday Holiday", date: Date.new(2023, 7, 31), description: 'Pahang' },
  { name: 'Special Public Holiday (State Election)', date: Date.new(2023, 8, 14), description: 'Selangor' },
  { name: 'Hari Hol Almarhum Sultan Iskandar', date: Date.new(2023, 8, 23), description: 'Johor' },
  { name: "Melaka Governor's Birthday", date: Date.new(2023, 8, 24), description: 'Melaka' },
  { name: 'Merdeka Day', date: Date.new(2023, 8, 31), description: 'National' },
  { name: 'Malaysia Day', date: Date.new(2023, 9, 16), description: 'National' },
  { name: 'Malaysia Day Holiday', date: Date.new(2023, 9, 17), description: 'Kelantan & Terengganu' },
  { name: "Prophet Muhammad's Birthday", date: Date.new(2023, 9, 28), description: 'National' },
  { name: "Sultan of Kelantan's Birthday", date: Date.new(2023, 9, 29), description: 'Kelantan' },
  { name: "Sultan of Kelantan's Birthday Holiday", date: Date.new(2023, 9, 30), description: 'Kelantan' },
  { name: "Sultan of Kelantan's Birthday Holiday", date: Date.new(2023, 10, 1), description: 'Kelantan' },
  { name: "Sabah Governor's Birthday", date: Date.new(2023, 10, 7), description: 'Sabah' },
  { name: "Sarawak Governor's Birthday", date: Date.new(2023, 10, 14), description: 'Sarawak' },
  { name: "Sultan of Perak's Birthday", date: Date.new(2023, 11, 3), description: 'Perak' },
  { name: 'Deepavali', date: Date.new(2023, 11, 12), description: 'National except Sarawak' },
  { name: 'Deepavali Holiday', date: Date.new(2023, 11, 13), description: 'National except Johor, Kedah, Kelantan, Sarawak & Terengganu' },
  { name: "Sultan of Selangor's Birthday", date: Date.new(2023, 12, 11), description: 'Selangor' },
  { name: 'Christmas Eve', date: Date.new(2023, 12, 24), description: 'Sabah' },
  { name: 'Christmas Day', date: Date.new(2023, 12, 25), description: 'National' },
  { name: 'Christmas Holiday', date: Date.new(2023, 12, 26), description: 'Sabah' },
  { name: "New Year's Eve", date: Date.new(2023, 12, 31), description: 'National' }
]

events_data.each do |event|
  Event.find_or_create_by(event)
end

events_2024 = [
  { name: "New Year's Day", date: Date.new(2024, 1, 1), description: 'National except Johor, Kedah, Kelantan, Perlis & Terengganu' },
  { name: "YDPB Negeri Sembilan's Birthday", date: Date.new(2024, 1, 14), description: 'Negeri Sembilan' },
  { name: "YDPB Negeri Sembilan's Birthday Holiday", date: Date.new(2024, 1, 15), description: 'Negeri Sembilan' },
  { name: 'Thaipusam', date: Date.new(2024, 1, 25), description: 'Johor, Kuala Lumpur, Negeri Sembilan, Penang, Perak, Putrajaya & Selangor' },
  { name: 'Federal Territory Day', date: Date.new(2024, 2, 1), description: 'Kuala Lumpur, Labuan & Putrajaya' },
  { name: 'Israk and Mikraj', date: Date.new(2024, 2, 8), description: 'Kedah, Negeri Sembilan, Perlis & Terengganu' },
  { name: 'Chinese New Year', date: Date.new(2024, 2, 10), description: 'National' },
  { name: 'Chinese New Year Holiday', date: Date.new(2024, 2, 11), description: 'National' },
  { name: 'Chinese New Year Holiday', date: Date.new(2024, 2, 12), description: 'National except Johor & Kedah' },
  { name: 'Independence Declaration Day', date: Date.new(2024, 2, 20), description: 'Melaka' },
  { name: 'Installation of Sultan Terengganu', date: Date.new(2024, 3, 4), description: 'Terengganu' },
  { name: 'Awal Ramadan', date: Date.new(2024, 3, 12), description: 'Johor, Kedah & Melaka' },
  { name: "Sultan of Johor's Birthday", date: Date.new(2024, 3, 23), description: 'Johor' },
  { name: 'Nuzul Al-Quran', date: Date.new(2024, 3, 28), description: 'National except Johor, Kedah, Melaka, Negeri Sembilan, Sabah & Sarawak' },
  { name: 'Good Friday', date: Date.new(2024, 3, 29), description: 'Sabah & Sarawak' },
  { name: 'Hari Raya Aidilfitri', date: Date.new(2024, 4, 10), description: 'National' },
  { name: 'Hari Raya Aidilfitri Holiday', date: Date.new(2024, 4, 11), description: 'National' },
  { name: "Sultan of Terengganu's Birthday", date: Date.new(2024, 4, 26), description: 'Terengganu' },
  { name: 'Labour Day', date: Date.new(2024, 5, 1), description: 'National' },
  { name: "Raja Perlis' Birthday", date: Date.new(2024, 5, 17), description: 'Perlis' },
  { name: 'Hari Hol Pahang', date: Date.new(2024, 5, 22), description: 'Pahang' },
  { name: 'Wesak Day', date: Date.new(2024, 5, 22), description: 'National' },
  { name: 'Hari Hol Pahang Holiday', date: Date.new(2024, 5, 23), description: 'Pahang' },
  { name: 'Harvest Festival', date: Date.new(2024, 5, 30), description: 'Labuan & Sabah' },
  { name: 'Harvest Festival Holiday', date: Date.new(2024, 5, 31), description: 'Labuan & Sabah' },
  { name: 'Hari Gawai', date: Date.new(2024, 6, 1), description: 'Sarawak' },
  { name: 'Hari Gawai Holiday', date: Date.new(2024, 6, 2), description: 'Sarawak' },
  { name: "Agong's Birthday", date: Date.new(2024, 6, 3), description: 'National' },
  { name: 'Hari Gawai Holiday', date: Date.new(2024, 6, 4), description: 'Sarawak' },
  { name: 'Arafat Day', date: Date.new(2024, 6, 16), description: 'Kelantan & Terengganu' },
  { name: 'Hari Raya Haji', date: Date.new(2024, 6, 17), description: 'National' },
  { name: 'Hari Raya Haji Holiday', date: Date.new(2024, 6, 18), description: 'Kedah, Kelantan, Perlis & Terengganu' },
  { name: "Sultan of Kedah's Birthday", date: Date.new(2024, 6, 30), description: 'Kedah' },
  { name: 'Georgetown World Heritage City Day', date: Date.new(2024, 7, 7), description: 'Penang' },
  { name: 'Awal Muharram', date: Date.new(2024, 7, 7), description: 'National' },
  { name: 'Awal Muharram Holiday', date: Date.new(2024, 7, 8), description: 'National except Johor, Kedah, Kelantan & Terengganu' },
  { name: 'Georgetown World Heritage City Holiday', date: Date.new(2024, 7, 9), description: 'Penang' },
  { name: "Penang Governor's Birthday", date: Date.new(2024, 7, 13), description: 'Penang' },
  { name: 'Sarawak Day', date: Date.new(2024, 7, 22), description: 'Sarawak' },
  { name: "Sultan of Pahang's Birthday", date: Date.new(2024, 7, 30), description: 'Pahang' },
  { name: 'Hari Hol Almarhum Sultan Iskandar', date: Date.new(2024, 8, 11), description: 'Johor' },
  { name: "Melaka Governor's Birthday", date: Date.new(2024, 8, 24), description: 'Melaka' },
  { name: 'Merdeka Day', date: Date.new(2024, 8, 31), description: 'National' },
  { name: 'Merdeka Day Holiday', date: Date.new(2024, 9, 1), description: 'Kelantan & Terengganu' },
  { name: "Prophet Muhammad's Birthday", date: Date.new(2024, 9, 16), description: 'National' },
  { name: 'Malaysia Day', date: Date.new(2024, 9, 16), description: 'National' },
  { name: 'Malaysia Day Holiday', date: Date.new(2024, 9, 17), description: 'National' },
  { name: "Sultan of Kelantan's Birthday", date: Date.new(2024, 9, 29), description: 'Kelantan' },
  { name: "Sultan of Kelantan's Birthday Holiday", date: Date.new(2024, 9, 30), description: 'Kelantan' },
  { name: "Sabah Governor's Birthday", date: Date.new(2024, 10, 5), description: 'Sabah' },
  { name: "Sarawak Governor's Birthday", date: Date.new(2024, 10, 12), description: 'Sarawak' },
  { name: 'Deepavali', date: Date.new(2024, 10, 31), description: 'National except Sarawak' },
  { name: "Sultan of Perak's Birthday", date: Date.new(2024, 11, 1), description: 'Perak' },
  { name: "Sultan of Selangor's Birthday", date: Date.new(2024, 12, 11), description: 'Selangor' },
  { name: 'Christmas Eve', date: Date.new(2024, 12, 24), description: 'Sabah' },
  { name: 'Christmas Day', date: Date.new(2024, 12, 25), description: 'National' }
]

events_2024.each do |event_data|
  Event.find_or_create_by(event_data)
end
