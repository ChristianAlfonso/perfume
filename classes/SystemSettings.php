<?php
if (!class_exists('DBConnection')) {
    require_once('../config.php');
    require_once('DBConnection.php');
}

class SystemSettings extends DBConnection {
    public function __construct() {
        parent::__construct();
    }

    // Check Database Connection
    function check_connection() {
        return $this->conn;
    }

    // Load System Information into Session
    function load_system_info() {
        $sql = "SELECT meta_field, meta_value FROM system_info";
        $qry = $this->conn->query($sql);
        while ($row = $qry->fetch_assoc()) {
            $_SESSION['system_info'][$row['meta_field']] = $row['meta_value'];
        }
    }

    // Update System Information
    function update_system_info() {
        $sql = "SELECT meta_field, meta_value FROM system_info";
        $qry = $this->conn->query($sql);
        while ($row = $qry->fetch_assoc()) {
            if (isset($_SESSION['system_info'][$row['meta_field']])) {
                unset($_SESSION['system_info'][$row['meta_field']]);
            }
            $_SESSION['system_info'][$row['meta_field']] = $row['meta_value'];
        }
        return true;
    }

    // Update Settings Information
    function update_settings_info() {
        $data = "";
        foreach ($_POST as $key => $value) {
            if (!in_array($key, array("about_us", "privacy_policy"))) {
                $value = $this->conn->real_escape_string($value);
                if (isset($_SESSION['system_info'][$key])) {
                    $qry = $this->conn->query("UPDATE system_info SET meta_value = '{$value}' WHERE meta_field = '{$key}'");
                } else {
                    $qry = $this->conn->query("INSERT INTO system_info (meta_field, meta_value) VALUES ('{$key}', '{$value}')");
                }
            }
        }

        // Update HTML Files
        if (isset($_POST['about_us'])) {
            file_put_contents('../about.html', $_POST['about_us']);
        }
        if (isset($_POST['privacy_policy'])) {
            file_put_contents('../privacy_policy.html', $_POST['privacy_policy']);
        }

        // Handle Logo Upload
        if (isset($_FILES['img']) && $_FILES['img']['tmp_name'] != '') {
            $fname = 'uploads/' . strtotime(date('Y-m-d H:i')) . '_' . $_FILES['img']['name'];
            move_uploaded_file($_FILES['img']['tmp_name'], '../' . $fname);
            if (isset($_SESSION['system_info']['logo'])) {
                $this->conn->query("UPDATE system_info SET meta_value = '{$fname}' WHERE meta_field = 'logo'");
                if (is_file('../' . $_SESSION['system_info']['logo'])) unlink('../' . $_SESSION['system_info']['logo']);
            } else {
                $this->conn->query("INSERT INTO system_info (meta_field, meta_value) VALUES ('logo', '{$fname}')");
            }
        }

        // Handle Cover Upload
        if (isset($_FILES['cover']) && $_FILES['cover']['tmp_name'] != '') {
            $fname = 'uploads/' . strtotime(date('Y-m-d H:i')) . '_' . $_FILES['cover']['name'];
            move_uploaded_file($_FILES['cover']['tmp_name'], '../' . $fname);
            if (isset($_SESSION['system_info']['cover'])) {
                $this->conn->query("UPDATE system_info SET meta_value = '{$fname}' WHERE meta_field = 'cover'");
                if (is_file('../' . $_SESSION['system_info']['cover'])) unlink('../' . $_SESSION['system_info']['cover']);
            } else {
                $this->conn->query("INSERT INTO system_info (meta_field, meta_value) VALUES ('cover', '{$fname}')");
            }
        }

        $update = $this->update_system_info();
        $flash = $this->set_flashdata('success', 'System Info Successfully Updated.');
        if ($update && $flash) {
            return true;
        }
    }

    // Set User Session Data
    function set_userdata($field = '', $value = '') {
        if (!empty($field) && !empty($value)) {
            $_SESSION['userdata'][$field] = $value;
        }
    }

    // Get User Session Data
    function userdata($field = '') {
        return $_SESSION['userdata'][$field] ?? null;
    }

    // Set Flash Message
    function set_flashdata($flash = '', $value = '') {
        if (!empty($flash) && !empty($value)) {
            $_SESSION['flashdata'][$flash] = $value;
            return true;
        }
        return false;
    }

    // Check Flash Message
    function chk_flashdata($flash = '') {
        return isset($_SESSION['flashdata'][$flash]);
    }

    // Get Flash Message
    function flashdata($flash = '') {
        if (!empty($flash)) {
            $_tmp = $_SESSION['flashdata'][$flash] ?? null;
            unset($_SESSION['flashdata'][$flash]);
            return $_tmp;
        }
        return false;
    }

    // Destroy User Session
    function sess_des() {
        if (isset($_SESSION['userdata'])) {
            unset($_SESSION['userdata']);
            return true;
        }
        return true;
    }

    // Get System Information
    function info($field = '') {
        return $_SESSION['system_info'][$field] ?? false;
    }

    // Set System Information
    function set_info($field = '', $value = '') {
        if (!empty($field) && !empty($value)) {
            $_SESSION['system_info'][$field] = $value;
        }
    }
}

// Initialize System Settings
$_settings = new SystemSettings();
$_settings->load_system_info();

$action = $_GET['f'] ?? 'none';

$sysset = new SystemSettings();
switch ($action) {
    case 'update_settings':
        echo $sysset->update_settings_info();
        break;
    default:
        break;
}


?>
