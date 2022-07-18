import { Identity } from "@semaphore-protocol/identity";
import keccak from "keccak256";

export function createIdentity(address: string, password: string) {
  /* Hash the address and password together */
  const deterministicSeed = keccak(address + password).toString("hex");
  let id = new Identity(deterministicSeed);
  return id;
}
