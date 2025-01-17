<?php
header('Content-Type: application/json');

// Replace these with your API credentials
$api_key = 'YOUR_API_KEY';
$api_url = 'https://api.paymentgateway.com/gcash/create';

// Get the data from the frontend
$amount = $_POST['amount'];
$description = $_POST['description'];
$client_id = $_POST['client_id'];

// Prepare payload for API request
$payload = [
    'amount' => $amount,
    'currency' => 'PHP',
    'description' => $description,
    'redirect' => [
        'success' => 'https://yourwebsite.com/success',
        'failed' => 'https://yourwebsite.com/failed',
    ],
    'metadata' => [
        'client_id' => $client_id,
    ],
];

// Debug: Log the payload
error_log("Payload: " . print_r($payload, true));

$ch = curl_init($api_url);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Authorization: Bearer ' . $api_key,
    'Content-Type: application/json',
]);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$response = curl_exec($ch);
$status_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

// Debug: Log the response and status code
error_log("HTTP Status Code: $status_code");
error_log("Response: $response");

curl_close($ch);

if ($status_code == 200) {
    echo $response;
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to create payment.']);
}
?>
