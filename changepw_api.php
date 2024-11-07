<?php
header("Content-Type: application/json");
require 'config.php';

// Mendapatkan data JSON dari request body
$data = json_decode(file_get_contents("php://input"));

// Inisialisasi respon default
$response = array("status" => false, "message" => "Semua field harus diisi");

// Validasi input JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    $response["message"] = "Format JSON tidak valid: " . json_last_error_msg();
    echo json_encode($response);
    exit();
}

// Validasi input
if (isset($data->user_id) && isset($data->current_password) && isset($data->new_password)) {
    $user_id = (int)$data->user_id;
    $current_password = trim($data->current_password);
    $new_password = trim($data->new_password);

    // Hash password yang diberikan
    $current_password_hashed = sha1($current_password);
    $new_password_hashed = sha1($new_password);

    // Query untuk memeriksa apakah current password cocok dengan user_id di semua tabel
    $sql = "
        SELECT 'admin' AS role FROM tb_admin WHERE admin_id = ? AND password = ?
        UNION
        SELECT 'siswa' AS role FROM tb_siswa WHERE siswa_id = ? AND password = ?
        UNION
        SELECT 'guru' AS role FROM tb_guru WHERE guru_id = ? AND password = ?;
    ";

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("isssss", $user_id, $current_password_hashed, $user_id, $current_password_hashed, $user_id, $current_password_hashed);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows > 0) {
            $user = $res->fetch_assoc();
            $role = $user['role'];

            // Update password pada tabel yang sesuai berdasarkan role
            $update_sql = "";
            if ($role == 'admin') {
                $update_sql = "UPDATE tb_admin SET password = ? WHERE admin_id = ?";
            } elseif ($role == 'siswa') {
                $update_sql = "UPDATE tb_siswa SET password = ? WHERE siswa_id = ?";
            } elseif ($role == 'guru') {
                $update_sql = "UPDATE tb_guru SET password = ? WHERE guru_id = ?";
            }

            $update_stmt = $conn->prepare($update_sql);
            if ($update_stmt) {
                $update_stmt->bind_param("si", $new_password_hashed, $user_id);
                $update_stmt->execute();

                if ($update_stmt->affected_rows > 0) {
                    $response = array(
                        "status" => true,
                        "message" => "Password berhasil diubah"
                    );
                } else {
                    $response["message"] = "Gagal mengubah password";
                }

                $update_stmt->close();
            } else {
                $response["message"] = "Kesalahan dalam query update: " . $conn->error;
            }
        } else {
            $response["message"] = "Password lama tidak cocok";
        }

        // Menutup statement
        $stmt->close();
    } else {
        $response["message"] = "Kesalahan dalam query: " . $conn->error;
    }
} else {
    $response["message"] = "User ID, current password, dan new password harus diisi.";
}

// Menutup koneksi
$conn->close();

// Mengirimkan hasil dalam format JSON
echo json_encode($response);
?>
