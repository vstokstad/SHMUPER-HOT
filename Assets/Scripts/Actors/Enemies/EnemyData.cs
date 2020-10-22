using UnityEngine;

namespace Actors.Enemies {
    [DefaultExecutionOrder(-1100)]
    [CreateAssetMenu(fileName = "New Enemy Data", menuName = "Scriptable/EnemyData", order = 1)]
    public class EnemyData : ScriptableObject {
        [Header("Statistics")] public float health = 1f;
        [Header("Move")] [Range(4, 12)] public float moveSpeed = 12f;
        [Header("Weapons")] public float crashDamage = 0.5f;
        [Header("Level")] public float enemyLevel = 1f;
    }
}