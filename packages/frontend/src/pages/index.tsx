import {ConnectButton} from "@rainbow-me/rainbowkit";
import type {NextPage} from "next";

const HomePage: NextPage = () => {
    return (
        <>
            <ConnectButton/>
            <ol>
                <li>1. Generate an identity</li>
                <li>2. Join a group</li>
                <li>3. Generate a proof of a vote</li>
                <li>4. Submit the vote</li>
                <li>5. Inspect the vote count</li>
            </ol>
        </>
    );
};

export default HomePage;
