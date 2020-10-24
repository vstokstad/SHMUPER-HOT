using System;
using UnityEngine;

namespace Actors.Player {
    [CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptable/PlayerData", order = 0)]
    public class PlayerData : ScriptableObject {
        [Header("Statistics")] [NonSerialized] public static float health = 10f;
        
        [NonSerialized] public static float boostCharge = 10f;

        public float highScore;

        [Header("Move")] [Range(4f, 20f)] public float maxSpeed = 10f;

        public float acceleration = 20f;

        private float _rechargeTimer;
        public bool ShieldIsLoaded { get; set; }


//Charges shield and booster
        public void RechargeTimer(){
            boostCharge = Mathf.Lerp(boostCharge, 10f, 0.5f * Time.fixedDeltaTime);
        }
    }
}