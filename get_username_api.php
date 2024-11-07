<?php
header("Content-Type: application/json");

require 'config.php';

$data = json_decode(file_get_contents("php://input"));
$response = array("status" => false, "message" => "User ID dan role harus disertakan");

// Cek apakah JSON yang diterima valid
if (json_last_error() !== JSON_ERROR_NONE) {
    $response["message"] = "Format JSON tidak valid: " . json_last_error_msg();
    echo json_encode($response);
    exit();
}

// Cek apakah user_id dan role ada di dalam data yang diterima
if (isset($data->user_id) && isset($data->role)) {
    $user_id = (int)$data->user_id;
    $role = $data->role;

    // Query berdasarkan role
    switch ($role) {
        case 'admin':
            $sql = "SELECT admin_id AS user_id, nama, 'admin' AS role FROM tb_admin WHERE admin_id = ?";
            break;
        case 'siswa':
            $sql = "SELECT siswa_id AS user_id, nama, 'siswa' AS role FROM tb_siswa WHERE siswa_id = ?";
            break;
        case 'guru':
            $sql = "SELECT guru_id AS user_id, nama, 'guru' AS role FROM tb_guru WHERE guru_id = ?";
            break;
        default:
            $response["message"] = "Role tidak valid";
            echo json_encode($response);
            exit();
    }

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows > 0) {
            $user = $res->fetch_assoc();
            $response = array(
                "status" => true,
                "message" => "Data user berhasil diambil",
                "user" => array(
                    "id" => (int)$user['user_id'],
                    "nama" => $user['nama'],
                    "role" => $user['role']
                )
            );
        } else {
            $response["message"] = "User tidak ditemukan";
        }

        $stmt->close();
    } else {
        $response["message"] = "Kesalahan dalam query: " . $conn->error;
    }
} else {
    $response["message"] = "User ID dan role tidak boleh kosong.";
}

$conn->close();
echo json_encode($response);
?>
