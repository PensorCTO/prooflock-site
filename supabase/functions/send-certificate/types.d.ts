// Type declarations for Deno runtime globals
// Note: Request and Response are available as global values in Deno runtime

declare module "https://deno.land/std@0.168.0/http/server.ts" {
  export function serve(
    handler: (req: Request) => Response | Promise<Response>
  ): void;
}

