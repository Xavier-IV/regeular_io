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
