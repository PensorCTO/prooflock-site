// Type declarations for Deno runtime globals
type Request = globalThis.Request;
type Response = globalThis.Response;

declare module "https://deno.land/std@0.168.0/http/server.ts" {
  export function serve(
    handler: (req: Request) => Response | Promise<Response>
  ): void;
}

