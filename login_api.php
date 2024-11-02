<?php
header("Content-Type: application/json");

error_reporting(E_ALL);
ini_set('display_errors', 1);

require 'config.php';

// Mendapatkan data JSON dari request body
$data = json_decode(file_get_contents("php://input"));
error_log(print_r($data, true)); // Log data yang diterima

// Inisialisasi respon
$response = array("status" => false, "message" => "Email dan password harus diisi");

// Validasi input JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    $response["message"] = "Format JSON tidak valid: " . json_last_error_msg();
    echo json_encode($response);
    exit();
}

if (isset($data->email) && isset($data->password)) {
    $email = trim($data->email);
    $password = trim($data->password);

    // Query untuk memeriksa user di tabel users
    $sql = "SELECT user_id, nama, email, password, nomor_hp, level_id FROM users WHERE email = ?";
    
    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows > 0) {
            $user = $res->fetch_assoc();

            // Verifikasi password
            if (md5($password) === $user['password']) { 
                $response = array(
                    "status" => true,
                    "message" => "Login berhasil",
                    "role" => (int)$user['level_id'],
                    "user" => array(
                        "id" => (int)$user['user_id'],
                        "nama" => $user['nama'],
                        "email" => $user['email'],
                        "nomor_hp" => $user['nomor_hp'] ?? ''
                    )
                );
            } else {
                $response["message"] = "Password salah";
            }
        } else {
            $response["message"] = "User tidak ditemukan";
        }

        // Menutup statement
        $stmt->close();
    } else {
        $response["message"] = "Kesalahan dalam query: " . $conn->error;
    }
} else {
    $response["message"] = "Email dan password tidak boleh kosong.";
}

// Menutup koneksi
$conn->close();

// Mengirimkan hasil dalam format JSON
echo json_encode($response);
?>
