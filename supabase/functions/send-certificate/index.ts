// Supabase Edge Function: send-certificate
// This function sends a certificate email with decryption instructions

// @ts-ignore - Deno runtime provides these types
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const htmlContent = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Certificate | ProofLock</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: #121212;
            color: #E0E0E0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #1E1E1E;
            border-radius: 20px;
            padding: 40px;
            border: 1px solid #333;
        }
        .logo {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 30px;
            text-transform: uppercase;
        }
        .logo span { color: #00D26A; }
        h1 {
            color: white;
            font-size: 24px;
            margin-bottom: 20px;
        }
        p {
            color: #A0A0A0;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .button {
            display: inline-block;
            background-color: #00D26A;
            color: black;
            padding: 15px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            margin: 20px 0;
            transition: background-color 0.2s;
        }
        .button:hover {
            background-color: #00B85A;
        }
        .footer {
            margin-top: 40px;
            font-size: 12px;
            color: #444;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">Proof<span>Lock</span></div>
        <h1>Your Secure Certificate</h1>
        <p>You have received a secure certificate file. To view and decrypt this file, please use the authorized viewer.</p>
        <p>Click the button below to download the viewer and access decryption instructions.</p>
        <a href="https://prooflock.io/decrypt.html" class="button">DOWNLOAD VIEWER & DECRYPT</a>
        <p style="font-size: 12px; color: #666;">If you have any questions, please contact the sender.</p>
        <div class="footer">
            &copy; 2025 ProofLock Inc. All Rights Reserved.
        </div>
    </div>
</body>
</html>
`

serve(async (req: Request) => {
  try {
    // Your function logic here
    // This is a template - implement your actual certificate sending logic
    
    // @ts-ignore - Response is a global in Deno runtime
    return new Response(JSON.stringify({ 
      message: "Certificate email sent",
      htmlContent: htmlContent 
    }), {
      headers: { "Content-Type": "application/json" },
      status: 200,
    })
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : String(error);
    // @ts-ignore - Response is a global in Deno runtime
    return new Response(JSON.stringify({ error: errorMessage }), {
      headers: { "Content-Type": "application/json" },
      status: 500,
    })
  }
})

